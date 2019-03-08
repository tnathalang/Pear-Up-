class Api::V1::UsersController < ApplicationController

    def index
        users = User.all
        render json: users
   
    end

    def show
        user = User.find(params[:id])
        render json: user
    end

    def create
        user = User.new(user_params)
        if user.save
          render json: { message: 'User created successfully' },
                 status: :created
        else
          render json: { errors: user.errors.full_messages },
                 status: :bad_request
        end
    end

    private

      def user_params
        params.require(:user).permit(
            :email,
            :password,
            :password_confirmation
            )
      end
end
