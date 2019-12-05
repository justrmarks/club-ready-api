class CommentsController < ApplicationController

    def show
        event = Event.find_by(params[:id])
        if event
            comments = event.comments
            render json: {comments: comments, event_id: event.id}
        else
            render json: {message: "No event found with given id"}
        end
    end

    def update
        comment = Comment.find_by(params[:id])

        if comment && comment.user_id == current_user.id
            comment.update(body: params[:body])
        end
    end

    def destroy
        comment = Comment.find_by(params[:id])
        if comment && (current_user.admin? || comment.user.id == comment.user_id)
            resp = comment.destroy
            render json: {comment: comment}
        else
            render json: {message: "comment could not be destroyed: only owners/admins can destroy comments"}
        end
    end



private

   

end




