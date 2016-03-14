# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(title: "Skill")
Category.create(title: "School Subject")
Category.create(title: "Sport")
Category.create(title: "Language")
Category.create(title: "Career")
Category.create(title: "Odd job")
Category.create(title: "Urgent")
Category.create(title: "Other")

Location.create(city: "London", normal: true)
Location.create(city: "NYC", normal: true)
Location.create(city: "LA", normal: true)
Location.create(city: "Vancouver", normal: true)
Location.create(city: "Toronto", normal: true)
Location.create(city: "Seattle", normal: true)
Location.create(city: "Other", normal: true)
