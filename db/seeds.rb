# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[:raincole, :zeta].each do |n|
  user = Factory(n)
  schedule = Factory(:schedule, :user => user)
  schedule.load_from_eportfolio(user.student_id)
end
