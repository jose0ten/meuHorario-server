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


$curricula = JSON.parse(open('app/assets/pingas/curricula.json').read)
puts 'curricula size ' << $curricula['curricula'].size.to_s

########################################################################## COURSES

def fillCourses
  puts 'initializing courses'
  puts 'finishing courses'
end

########################################################################## WORKLOADS

def fillWorkloads
  puts 'initializing workloads'
  puts 'finishing workloads'
end

########################################################################## COURSE INSTANCES

def fillCourseInstances
  puts 'initializing course instances'
  puts 'finishing course instances'
end

########################################################################## TIMESLOTS

def fillTimeslots
  puts 'initializing timeslots'
  puts 'finished timeslots'
end

########################################################################## GRADUATIONS

def fillGraduations


end




fillCourses

fillWorkloads

fillCourseInstances

fillTimeslots

fillGraduations

