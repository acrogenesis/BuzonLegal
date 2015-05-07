require 'csv'

namespace :topolegal do
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

    date_str = date.strftime('%d-%m-%Y')
    read_files(date_str)
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
      ["BajaCaliforniaNorte", "BajaCaliforniaSur", "Jalisco", "Guanajuato"].each do |state|
        system date.present? ? "ruby topo.rb #{state}:Boletines -output csv #{path} -date #{date}" : "ruby topo.rb #{state}:Boletines -output csv #{path}"
      end
    end

    if date
      date_str = Date.strptime(args[:date],'%d/%m/%Y')
    else
      date_str = Date.today - 1
    end
    read_files(date_str.strftime('%d-%m-%Y'))
  end

  def read_files(date_str)
    # se toma del ambiente de la computadora
    # export CSVDIR="/path/to/csvs/"
    path = ENV['CSVDIR'] ? ENV['CSVDIR'] : ''
    State.all.each do |state|
      filename = "#{path}#{state.name}-#{date_str}.csv"
      begin
        CSV.foreach(filename, {:headers => true, :col_sep => "|"}) do |row|
          rhash = row.to_hash
          tribunal = Tribunal.find_or_create_by(name: rhash['Juzgado'], state: state)
          fecha = Date.strptime(rhash['Fecha'],"%d-%m-%Y")
          tcase = Case.find_or_create_by(
            date: fecha,
            casenumber: rhash['Expediente'],
            description: rhash['Descripcion'],
            tribunal: tribunal,
          )
        end
        state.online = true
        state.last_time_online = date
      rescue Errno::ENOENT
        puts "WARNING: Failed to locate CSV for #{state.name}"
      end
    end
  end
end
