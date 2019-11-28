# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Event.destroy_all
User.destroy_all

User.create(email:"seed@groove.cafe",name: "user account for seeding db", password:"12345", role: 1, aboutme:"just for development, delete if found")

client = GoogleCalendarWrapper.new

client.seed_events