# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def convertToHour(time, hour)
  cHour = hour.to_i
  if (time === 'M')
    return cHour + 6
  end
  if (time === 'T')
    return cHour + 12
  end
  if (time === 'N')
    return cHour + 18
  end
  return cHour
end

def toTimeslotArray(times)
  newObj = {}
  i = 0
  times.split(' ').each do |time|
    regex = /(([1-9]*)(T|M|N)([1-9]*))/
    myTime = time.scan(regex)

    if !myTime.empty?

      dias = myTime[0][1].to_s
      turno = myTime[0][2]
      horas = myTime[0][3].to_s

      dias.each_char do |element|
        newObj[i] = {
          day: element.to_i - 2,
          startingHour: convertToHour(turno, horas[0]),
          endingHour: convertToHour(turno, horas[horas.length - 1]) + 1,
        }
        i += 1
      end

    end

  end
  return newObj
end


timetable = JSON.parse(open('app/assets/pingas/timetable.json').read)
puts 'timeslot size ' << timetable['time'].size.to_s

def fillTimeslots
  timetable['time'].each do |current|
    current['turmas'].each do |classe|

      ################################################ searching and filling timeslots
      puts 'begining timeslots'
      result = toTimeslotArray(classe['horario'])
      unless result.empty?

        result.each do |slot|
          timeslot = Timeslot.where(
                                    day: slot[1][:day].to_i,
                                    starting_hour: slot[1][:startingHour].to_i,
                                    ending_hour: slot[1][:endingHour].to_i
          )

          if timeslot.empty?

            timeslot = Timeslot.new() do |time|

              time.day = slot[1][:day]
              time.starting_hour = slot[1][:startingHour]
              time.ending_hour = slot[1][:endingHour]

            end
            timeslot.save!

          end

        end
      end
      ################################################ end timeslots
      puts 'finished timeslots'

    end
  end
end

curricula = JSON.parse(open('app/assets/pingas/curricula.json').read)
puts 'curricula size ' << curricula['curricula'].size.to_s
course = []
i = 0
curricula['curricula'].each do |current|

  course[i] = JSON.parse(open("app/assets/pingas/#{current['codigo']}.json").read)

  course[i]['curriculum']['courses'].each do |course|

    #puts course['workload']

  end


  i += 1
end

puts course.size

