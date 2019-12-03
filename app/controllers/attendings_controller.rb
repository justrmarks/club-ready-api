class AttendingsController < ApplicationController

    def create
        user = current_user
        event = Event.find_by(id: params[:id])
        
        attending = user.attendings.build(event: event)
        if attending.save
            render json: {message: "Now attending #{event.title}", event: EventSerializer.new(event)} 
        else
            render json: {message: "Error Creating attnending", errors: event.errors.full_messages}
        end
    end

    def destroy
        user = current_user
        event = Event.find_by(id: params[:id])
        attending = Attending.find_by(event_id: event.id, user_id: user.id)
        if (attending)
            resp = attending.destroy
            render json: {message: "no longer attending #{event.title}", event: EventSerializer.new(event)}
        else
            render json: {message: "couldn't find attending with given parmas"}
        end
    end

end
