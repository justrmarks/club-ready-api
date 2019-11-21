require 'google/apis/calendar_v3'
require 'googleauth'

scope = 'https://www.googleapis.com/auth/calendar'

authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
  json_key_io: File.open('secrets/project-sploopy-d9c223115cef.json'),
  scope: scope)

authorizer.fetch_access_token!

service = Google::Apis::CalendarV3::CalendarService.new
service.authorization = authorizer

calendar_id = 'shedaddy.com_4vnet367h9mkljq5gm3j85oi00@group.calendar.google.com'
response = service.list_events(calendar_id,
                               max_results: 10,
                               single_events: true,
                               order_by: 'startTime',
                               time_min: Time.now.iso8601)
puts 'Upcoming events:'
puts 'No upcoming events found' if response.items.empty?
response.items.each do |event|
  start = event.start.date || event.start.date_time
  puts "- #{event.summary} (#{start})", event.methods
end