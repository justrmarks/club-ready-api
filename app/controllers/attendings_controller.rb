class AttendingsController < ApplicationController

    def create
        user = current_user
        event = Event.find_by(id: params[:id])
        
        attending = user.attendings.build(event: event)
        if attending.save
            render json: {message: "Now attending #{event.title}", event: EventSerializer.new(event, event_serializer_params(event))} 
        else
            render json: {message: "Error Creating attnending", errors: event.errors.full_messages}
        end
    end

    def destroy
        user = current_user
        event = Event.find_by(id: params[:id])
        attendings = Attending.select {|attending| attending.event_id == event.id && attending.user_id == user.id}
        if (attendings.size > 0)
            resp = attendings.map {|att| att.destroy}
            render json: {message: "no longer attending #{event.title}", event: EventSerializer.new(event, event_serializer_params(event))}
        else
            render json: {message: "couldn't find attending with given parmas"}
        end
    end


    private 

    def event_serializer_params(event)
        result = {params: {current_user: current_user}}
        if event.picture_file.attached?
            result[:params][:img_url] = url_for(event.picture_file)
            puts "********event serializer params*******", result
        end
        
        result
        
    end

end
