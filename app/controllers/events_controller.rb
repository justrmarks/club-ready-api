class EventsController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :authenticate_user!, only: [:index, :show]

    def index
        puts params[:month]
        select_month = params[:month] ? params[:month].to_i : select_month = Time.now.month
        events = Event.all.select do |event| 
            event.start_time.month < select_month + 2 || event.start_time.month > select_month - 2  
        end

        send_events = events.map {|event| EventSerializer.new(event, (event_serializer_params(event)))}
        render json: {events: send_events}, status: :ok
    end

    def show
        event = Event.find_by(id: params[:id])
        if (event)
            comments = event.comments.map {|comment| CommentSerializer.new(comment) }
            render json: {comments: comments, event: EventSerializer.new(event, (event_serializer_params(event)))}
        else
            render json: {message: "Event not found"}, status: 404
        end
    end

    def create
        if current_user.organizer? || current_user.admin?
            event = Event.new(event_params)
            event.host = current_user
            if event.save 
                render json: {message: "Event created", event: EventSerializer.new(event, (event_serializer_params(event)))}
            else
                render json: {message: "Error creating event", error: event.errors.full_messages}
            end
        else
            render json: {message: "Only organizers can add events to the calendar"}, status: :unauthorized
        end
    end

    def attending
        events = Event.all.select { |event| event.attendees.include?(current_user) }
        send_events = events.map {|event| EventSerializer.new(event, (event_serializer_params(event)))}
        render json: {events: send_events}, status: :ok
    end

    def hosting
        events = Event.all.select { |event| event.host.id == current_user.id }.sort {|a,b| a.start_time <=> b.start_time }
        send_events = events.map {|event| EventSerializer.new(event, (event_serializer_params(event)))}
        render json: {events: send_events}, status: :ok
    end



    private

    def event_params
        params.require(:event).permit(:title, :description, :start_time, :end_time, 
            :location, :bathrooms, :water, :mobility, :flashing_lights, :picture_file)
    end

    def event_serializer_params(event)
        result = {params: {current_user: current_user}}
        if event.picture_file.attached?
            result[:params][:img_url] = url_for(event.picture_file)
        end
        
        result
        
    end

end


