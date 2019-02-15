# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require './lib/modules/timeslot_module'
require './lib/modules/workload_module'



$timetable = JSON.parse(open('app/assets/pingas/timetable.json').read)['time']
puts 'timeslot size ' << $timetable.size.to_s


$curricula = JSON.parse(open('app/assets/pingas/curricula.json').read)['curricula']
puts 'curricula size ' << $curricula.size.to_s

########################################################################## WORKLOADS

def fillWorkloads
  puts 'initializing workloads'

  i = 0
  $curricula.each do |program|

    single = JSON.parse(open("app/assets/pingas/#{program['codigo']}.json").read)

    unless single['curriculum']['courses'].empty?
      single = single['curriculum']['courses']

      single.each do |workload|

        if workload['workload'] == nil
          next
        end

        result = WorkloadModule.toWorkloadArray(workload['workload'])



        singleCourse = Workload.where(
          classroom: result[:classroom],
          lab: result[:lab],
          total: result[:total]
        )

        if singleCourse.empty?
          puts "workload #{workload['id']} empty \t" # << workload['id']
          singleCourse = Workload.new() do |newWorkload|
            newWorkload.classroom = result[:classroom]
            newWorkload.lab = result[:lab]
            newWorkload.total = result[:total]
          end
          singleCourse.save
          puts singleCourse.persisted?
        end
        i += 1

      end

    else
      puts single['curriculum']['name'] << ' ' << single['curriculum']['codigo']
    end
  end
  puts "#{i} workloads"


  puts 'finishing workloads'
end

########################################################################## COURSES

def fillCourses
  puts 'initializing courses'
  i = 0
  $curricula.each do |program|

    single = JSON.parse(open("app/assets/pingas/#{program['codigo']}.json").read)

    unless single['curriculum']['courses'].empty?
      single = single['curriculum']['courses']

      single.each do |course|


        result =  course['workload']? WorkloadModule.toWorkloadArray(course['workload']) : {classroom:0, lab: 0, total:0}

        currWork = Workload.where(
          classroom: result[:classroom],
          lab: result[:lab],
          total: result[:total]
        )[0]

        singleCourse = Course.where(
          code: course['id'],
          name: course['name'],
          course_type: course['type'],
          category: course['category'],
          semester: course['semester'].to_i,
          workload: currWork
        )

        if singleCourse.empty?
          puts "course #{course['id']} empty \t" # << course['id']
          i += 1
          singleCourse = Course.new() do |newCourse|
            newCourse.code = course['id']
            newCourse.name = course['name']
            newCourse.course_type = course['type']
            newCourse.category = course['category']
            newCourse.semester = course['semester'].to_i
            newCourse.workload = currWork
          end
          singleCourse.save
          puts singleCourse.persisted?
        end
        i += 1

      end

    else
      puts single['curriculum']['name'] << ' ' << single['curriculum']['codigo']
    end
  end
  puts "#{i} courses"
  puts 'finishing courses'
end

########################################################################## COURSE INSTANCES

def fillCourseInstances
  puts 'initializing course instances'
  i = 0

  $timetable.each do |program|
    program['turmas'].each do |classInst|
      currCourse = Course.where(
        code: classInst['id'],
      )[0]


      instance = CourseInstance.where(
        class_id: classInst['turmaid'],
        timestamp: classInst['horario'],
        professor: classInst['professor'],
        date_semester: classInst['semester'],
        course: currCourse
      )
      if instance.empty?
        puts 'course instance empty'

        instance = CourseInstance.new() do |inst|

          inst.class_id = classInst['turmaid']
          inst.timestamp = classInst['horario']
          inst.professor = classInst['professor']
          inst.date_semester = classInst['semester']
          inst.course = currCourse

        end

        instance.save
        puts instance.persisted?
      end
      i += 1

    end
  end
  puts "#{i} course instances"

  puts 'finishing course instances'
end

########################################################################## TIMESLOTS

def fillTimeslots
  puts 'initializing timeslots'
  i = 0

    $timetable.each do |course|
      course['turmas'].each do |times|

        result = TimeslotModule.toTimeslotArray(times['horario'])

        unless result.empty?

          instance = CourseInstance.where(
            class_id: times['turmaid'],
            course: Course.where(
              code: times['id']
            )
          )[0]

          result.each do |slot|

            timeslot = Timeslot.where(
                                      day: slot[1][:day].to_i,
                                      starting_hour: slot[1][:startingHour].to_i,
                                      ending_hour: slot[1][:endingHour].to_i,
                                      course_instance: instance
            )

            if timeslot.empty?
              puts "timeslot #{i} empty"
              timeslot = Timeslot.new() do |time|

                time.day = slot[1][:day]
                time.starting_hour = slot[1][:startingHour]
                time.ending_hour = slot[1][:endingHour]
                time.course_instance = instance

              end
              timeslot.save!
              puts timeslot.persisted?

            end
            i += 1
          end
        end
      end
    end

  puts "#{i} timeslots"
  puts 'finished timeslots'
end

########################################################################## GRADUATIONS

def fillGraduations
  puts 'initializing graduations'
  puts 'finished graduations'
end



fillWorkloads

fillCourses

fillCourseInstances

fillTimeslots

fillGraduations
