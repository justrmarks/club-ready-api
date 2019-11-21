require 'concerns/google_calendar_wrapper'

class Event < ApplicationRecord
    # associations
    belongs_to :host, class_name: "User", foreign_key: "host_id"
    has_many :attendings
    has_many :attendees, through: :attendings


    # lifecycle hooks
    before_create :create_google_event
    after_update :update_google_event
    before_destroy :delete_google_event

    def create_google_event
        calendar = GoogleCalendarWrapper.new
        google_event = calendar.create_event(self)
        self.google_id = google_event.id
    end

    def update_google_event
        calendar = GoogleCalendarWrapper.new
        calendar.update_event(self)
    end

    def delete_google_event
        calendar = GoogleCalendarWrapper.new
        calendar.delete_event(self)
    end




    
end
