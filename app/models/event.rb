require 'concerns/google_calendar_wrapper'

class Event < ApplicationRecord
    enum bathrooms: [:no_bathrooms, :portos, :single_stalls, :gendered_bathrooms, :all_gender]
    enum water: [:no_water, :water_for_sale, :free_water]
    enum mobility: [:inaccessible, :partially_accessible, :wheelchair_accessible]
    # associations
    belongs_to :host, class_name: "User", foreign_key: "host_id"
    has_many :attendings
    has_many :attendees, through: :attendings
    has_many :comments

    # activeStorage methods
    has_one_attached :picture_file

    # lifecycle hooks
    before_create :create_google_event
    after_update :update_google_event
    before_destroy :delete_google_event

    def create_google_event
        unless self.google_id && self.google_link
            calendar = GoogleCalendarWrapper.new
            google_event = calendar.create_event(self)
            self.google_id = google_event.id
            self.google_link = google_event.html_link
        end
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
