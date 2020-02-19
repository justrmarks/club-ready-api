require 'google/apis/calendar_v3'
require 'googleauth'
require 'stringio'

class GoogleCalendarWrapper
   
    def initialize
        sio = StringIO.new
        sio.print(ENV['google_secrets'])
        scopes = ['https://www.googleapis.com/auth/calendar', 'https://www.googleapis.com/auth/calendar.events']
        authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
        json_key_io: sio, #File.open('/Users/shedaddy/Development/Groove_Cafe_capstone/project-sploopy-api/secrets/project-sploopy-d9c223115cef.json'),
        scope: scopes)
        authorizer.fetch_access_token!
        @client = Google::Apis::CalendarV3::CalendarService.new
        @client.authorization = authorizer
        @calendar_id = 'shedaddy.com_4vnet367h9mkljq5gm3j85oi00@group.calendar.google.com'
    end

    def create_event(new_event)

        event = Google::Apis::CalendarV3::Event.new({summary: new_event.title,
            location: new_event.location,
            description: new_event.description,
            start: {
              date_time: new_event.start_time.rfc3339
            },
            end: {
              date_time: new_event.end_time.rfc3339
            },
          })
          result = @client.insert_event(@calendar_id, event)     
          return result
    end

    def update_event(updated_event)
        puts "*******updated event*******", updated_event.google_id
        puts "*******calendar_id *******", @calendar_id
        byebug
        event = @client.get_event(@calendar_id, updated_event.google_id)
        event.summary = updated_event.title
        event.location = updated_event.location
        event.description = updated_event.description
        event.start = {
            date_time: updated_event.start_time.rfc3339
        }
        event.end = {
            date_time: updated_event.end_time.rfc3339
        }
        result = @client.update_event(@calendar_id, updated_event.google_id, event)
    end

    def delete_event(deleted_event)
        puts "******entered delete event*******", deleted_event
        puts "***********state of @client*******", @client
        @client.delete_event(@calendar_id, deleted_event.google_id)
    end

    def seed_events
        result = @client.list_events(@calendar_id)
        puts result.items
        result.items.each do |g_event|
            
            event = Event.new({
                google_id: g_event.id,
                google_link: g_event.html_link,
                title: g_event.summary,
                description: g_event.description,
                location: g_event.location,
                start_time: g_event.start.date_time,
                end_time: g_event.end.date_time,
                host: User.find_by({email: 'seed@groove.cafe'}),
                bathrooms: 0,
                water: 0,
                flashing_lights: true,
                mobility: 0
            })
            puts event

            if event.save
                puts event
            else
                puts event.errors.full_messages
            end



        end

    end


end