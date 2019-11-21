class EventSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :start_time, :end_time, :location


  attribute :host do |event|
    UserSerializer.new(event.host)
  end

  attribute :attendees do |event| 
    
    event.attendees.map do |user| 
      UserSerializer.new(user)
    end

  end
  
end
