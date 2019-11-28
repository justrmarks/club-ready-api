class EventsController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :authenticate_user!, only: [:index, :show]

    def index
        params[:year] ? current_year = params[:year] : current_year = Time.now.year
        events = Event.all.select do |event| 
            event.start_time.year == current_year
        end
        send_events = events.map {|event| EventSerializer.new(event)}
        render json: {events: send_events}, status: :ok
    end

    def show
    end

    def create
        if current_user.organizer? || current_user.admin?
            event = Event.create(params[:event])
        else
            render json: {message: "Only organizers can add events to the calendar"}, status: :unauthorized
        end
    end

    
end
