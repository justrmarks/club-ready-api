# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Event.destroy_all
User.destroy_all

user = User.create(email:"seed@groove.cafe",name: "user account for seeding db", password:"12345", role: 1, aboutme:"just for development, delete if found")

50.times do |i|
    time = Time.now + rand(i).days
    event = Event.create(title: "Event #{i}", host: user, description: "This is a test event", location: "my house", start_time: time, end_time: time + 2.hours, bathrooms: 0, water: 0, mobility: 0, flashing_lights: true)

    if ([true,false].sample) 
        event.attendees << user
    end
    
    5.times do |i|
        event.comments.build(user: user, body: "This is comment number #{i}")
    end
end



