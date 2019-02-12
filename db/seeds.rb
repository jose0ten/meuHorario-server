# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require './lib/modules/timeslot_module'
require './lib/modules/workload_module'



$timetable = JSON.parse(open('app/assets/pingas/timetable.json').read)
puts 'timeslot size ' << $timetable['time'].size.to_s

def fillTimeslots
  puts 'initializing timeslots'
  $timetable['time'].each do |current|
    current['turmas'].each do |classe|

      ################################################ searching and filling timeslots
      result = TimeslotModule.toTimeslotArray(classe['horario'])
      unless result.empty?

        result.each do |slot|
          timeslot = Timeslot.where(
                                    day: slot[1][:day].to_i,
                                    starting_hour: slot[1][:startingHour].to_i,
                                    ending_hour: slot[1][:endingHour].to_i
          )

          if timeslot.empty?
            puts 'timeslot empty'
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

    end
  end
  puts 'finished timeslots'
end


$curricula = JSON.parse(open('app/assets/pingas/curricula.json').read)
puts 'curricula size ' << $curricula['curricula'].size.to_s

def fillWorkloads
  puts 'initializing workloads'
  course = []
  i = 0
  $curricula['curricula'].each do |current|

    course[i] = JSON.parse(open("app/assets/pingas/#{current['codigo']}.json").read)

    course[i]['curriculum']['courses'].each do |course|

      if course['workload'] == nil
        next
      end

      result = WorkloadModule.toWorkloadArray(course['workload'])

      workload = Workload.where(
                                classroom: result[:classroom],
                                lab: result[:lab],
                                total: result[:total]
      )

      if workload.empty?
        puts 'workload empty'
        workload = Workload.new() do |load|
          load.classroom = result[:classroom]
          load.lab = result[:lab]
          load.total = result[:total]
        end
        workload.save!
      end
    end
    i += 1
  end

  puts course.size
  puts 'finishing workloads'
end

fillTimeslots

fillWorkloads
