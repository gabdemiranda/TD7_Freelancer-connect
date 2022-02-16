module Api
  module V1
    class ApiUsersController < Api::V1::ApiController
      before_action :authorized, only: [:auto_login]

      # REGISTER
      def create
        @api_user = ApiUser.create(api_user_params)
        if @api_user.valid?
          token = encode_token({api_user_id: @api_user.id})
          render json: {api_user: @api_user, token: token}
        else
          render json: {error: "Invalid username or password"}
        end
      end

      # LOGGING IN
      def login
        @api_user = ApiUser.find_by(username: params[:username])

        if @api_user && @api_user.authenticate(params[:password])
          token = encode_token({api_user_id: @api_user.id})
          render json: {api_user: @api_user, token: token}
        else
          render json: {error: "Invalid username or password"}
        end
      end

      def auto_login
        render json: @api_user
      end

      private

      def api_user_params
        params.permit(:username, :password)
      end
    end
  end
end 