class UsersController < ApplicationController
  before_action :authenticate, except: :create

  def show
    render json: current_user
  end

  def update
    @user = User.find(user_id)
    logger.debug user_params.inspect
    if @user.update_attributes(user_params)
      render json: @user
    else
      render json: @user, status: 422, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: @user, status: 422, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  private

  def user_id
    params[:data][:id]
  end

  def user_params
    pms = ActiveModelSerializers::Deserialization.jsonapi_parse!(params, :only => [:name, :username, :password, :password_confirmation])
    pms.delete(:password) if pms[:password].nil?
    pms
  end
end
