# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

input = JSON.parse(open('app/assets/pingas/timetable.json').read)
puts input['time'].size

input['time'].each do |current|
  puts current['id']

#  begin
#    text = open('app/assets/pingas/' << current.to_s << '.json').read
#  rescue StandardError => bang
#    puts current
#    puts bang
#  end
end
