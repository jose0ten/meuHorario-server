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

########################################################################## COURSES

def fillCourses
  puts 'initializing courses'
  i = 0
  $curricula.each do |program|

    single = JSON.parse(open("app/assets/pingas/#{program['codigo']}.json").read)

    unless single['curriculum']['courses'].empty?
      single = single['curriculum']['courses']

      single.each do |course|

        singleCourse = Course.where(
          code: course['id'],
          name: course['name'],
          course_type: course['type'],
          category: course['category'],
          semester: course['semester'].to_i
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
          end
          singleCourse.save
          puts singleCourse.persisted?
        end

      end

    else
      puts single['curriculum']['name'] << ' ' << single['curriculum']['codigo']
    end
  end
  puts "#{i} courses"
  puts 'finishing courses'
end

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


        currCourse = Course.where(
          code: workload['id'],
          name: workload['name'],
          course_type: workload['type'],
          category: workload['category'],
          semester: workload['semester'].to_i
        )[0]


        singleCourse = Workload.where(
          classroom: result[:classroom],
          lab: result[:lab],
          total: result[:total],
          course: currCourse
        )

        if singleCourse.empty?
          puts "workload #{workload['id']} empty \t" # << workload['id']
          i += 1
          singleCourse = Workload.new() do |newWorkload|
            newWorkload.classroom = result[:classroom]
            newWorkload.lab = result[:lab]
            newWorkload.total = result[:total]
            newWorkload.course = currCourse
          end
          singleCourse.save
          puts singleCourse.persisted?
        end

      end

    else
      puts single['curriculum']['name'] << ' ' << single['curriculum']['codigo']
    end
  end
  puts "#{i} workloads"


  puts 'finishing workloads'
end

########################################################################## COURSE INSTANCES

def fillCourseInstances
  puts 'initializing course instances'

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


    end
  end

  puts 'finishing course instances'
end

########################################################################## TIMESLOTS

def fillTimeslots
  puts 'initializing timeslots'
  puts 'finished timeslots'
end

########################################################################## GRADUATIONS

def fillGraduations
  puts 'initializing graduations'
  puts 'finished graduations'
end



fillCourses

fillWorkloads

fillCourseInstances

fillTimeslots

fillGraduations

test = Workload.all

puts test.inspect
