require_dependency "knock/application_controller"

module Knock
  class AuthTokenController < ApplicationController
    before_action :authenticate!

    def create
      render json: { jwt: auth_token.token, user_id: user.id }, status: :created
    end

  private
    def authenticate!
      if user.authenticate(auth_params[:password])
        return true
      else
        render json: { error: "Sorry, we could not find a user with that username and password"}, status: :not_found
      end
    end
    #
    def auth_token
      AuthToken.new payload: { sub: user.id }
    end

    def user
      Knock.current_user_from_handle.call auth_params[Knock.handle_attr]
    end

    def auth_params
     params.require(:auth_token).permit Knock.handle_attr, :password
   end
  end
end
