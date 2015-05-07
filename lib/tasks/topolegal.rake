require 'csv'

namespace :topolegal do
  # usage:
  # rake topolegal:boletines[date]
  # date has to have dd/mm/YYYY order
  desc 'Parses each State CSV file into the database, see file for usage'
  task :boletines, [:date] => [:environment] do |t, args|

    if args[:date]
      date = args[:date].split("/").join("-")
    else
      date = (Date.today - 1).strftime('%d-%m-%Y')
    end

    # se toma del ambiente de la computadora
    # export CSVDIR="/path/to/csvs/"
    path = ENV['CSVDIR'] ? ENV['CSVDIR'] : ''

    State.all.each do |state|

      filename = "#{path}#{state.name}-#{date}.csv"

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

      rescue Errno::ENOENT
        puts "WARNING: Failed to locate CSV for #{state.name}"
      end


    end

  end

end
