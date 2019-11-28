class UsersController < ApplicationController
    before_action :authenticate_user!
  
    def create
    end

    def show

    end

    def index
    end

    def auth
      if current_user
        render json: {current_user: current_user, valid: true}, status: :ok
      else
        render json: {valid: false}, status: :unauthorized
      end
    end
  
    private   
  
  end
  