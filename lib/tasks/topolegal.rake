require 'csv'

namespace :topolegal do
  STATES = ["BajaCaliforniaNorte", "BajaCaliforniaSur", "Jalisco", "Guanajuato"]
  # usage:
  # rake topolegal:boletines[date]
  # date has to have dd/mm/YYYY order
  desc 'Parses each State CSV file into the database, see file for usage'
  task :boletines, [:date] => [:environment] do |t, args|

    if args[:date]
      date = Date.strptime(args[:date],'%d/%m/%Y')
    else
      date = Date.today - 1
    end

    Dir.chdir(ENV['TOPODIR']) do
      read_files(date)
    end
  end

  # usage:
  # rake topolegal:magic[date]
  # date has to have dd/mm/YYYY order
  desc 'Runs Topo to scrap bulletins and then runs task to parse them'
  task :magic, [:date] => [:environment] do |t, args|
    if args[:date]
      date = args[:date].split("/").reverse.join("/")
    end
    path = ENV['CSVDIR'] ? "-destination #{ENV['CSVDIR']}" : ''

    Dir.chdir(ENV['TOPODIR']) do
      STATES.each do |state|
        system date.present? ? "ruby topo.rb #{state}:Boletines -output csv #{path} -date #{date}" : "ruby topo.rb #{state}:Boletines -output csv #{path}"
      end
    end

    if date
      date = Date.strptime(args[:date],'%d/%m/%Y')
    else
      date = Date.today - 1
    end
    Dir.chdir(ENV['TOPODIR']) do
      read_files(date)
    end
  end

  def read_files(date)
    date_str = date.strftime('%d-%m-%Y')
    # se toma del ambiente de la computadora
    # export CSVDIR="/path/to/csvs/"
    path = ENV['CSVDIR'] ? ENV['CSVDIR'] : ''
    STATES.each do |state_name|
      state = State.find_or_create_by(name: state_name)
      state.update_attributes(last_time_online: date, online: true)
      filename = "#{path}#{state.name}-#{date_str}.csv"
      begin
        CSV.foreach(filename, {:headers => true, :col_sep => "|"}) do |row|
          rhash = row.to_hash
          tribunal = Tribunal.find_or_create_by(name: rhash['Juzgado'], state: state)
          fecha = Date.strptime(rhash['Fecha'],"%d-%m-%Y")
          Case.find_or_create_by(
            date: fecha,
            casenumber: rhash['Expediente'],
            description: rhash['Descripcion'],
            tribunal: tribunal,
          )
        end
        state.online = true
        state.last_time_online = date
      rescue => e
        puts "WARNING: Failed to locate CSV for #{state.name}"
        puts e
      end
    end
    filename = "#{path}Log-#{date_str}.csv"
    begin
      CSV.foreach(filename, {:headers => true, :col_sep => "|"}) do |row|
        rhash = row.to_hash
        state = State.find_by(name: rhash['Estado'])
        fecha = Date.strptime(rhash['Fecha'],"%d-%m-%Y")
        descripcion = "#{rhash['Tipo']}: #{rhash['Mensaje']}"

        Incident.create(state: state, created_at: fecha, description: descripcion)
        state.update_attributes(online: false, last_time_online: date)
      end
    rescue => e
      puts "No incidents found."
      puts e
    end
  end
end
