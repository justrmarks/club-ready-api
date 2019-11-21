class EventsController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :authenticate_user!, only: [:index, :show]

    def index
        events = Event.all.map {|event| EventSerializer.new(event)}
        render json: {events: events}, status: :ok
    end

    def show
    end

    def create
        if current_user.organizer? 

        else
            render json: {message: "Only organizers can add events to the calendar"}, status: :unauthorized
        end
    end

    
end
