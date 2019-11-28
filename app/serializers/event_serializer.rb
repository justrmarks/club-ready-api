class EventSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :description, :start_time, :end_time, :location, :google_link


  attribute :host do |event|
    event.host
  end

  attribute :attendees do |event| 
    event.attendees.map do |user| 
      UserSerializer.new(user)
    end

  end
  
end
