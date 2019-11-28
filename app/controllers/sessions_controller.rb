class SessionsController < Devise::SessionsController
    respond_to :json
  
    private
  
    def respond_with(user, _opts = {})
      render json: {user:user}
    end
  
    def respond_to_on_destroy
      head :no_content
    end
  end