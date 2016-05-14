class ListsController < ApplicationController
  before_action :authenticate

  def index
    # raise "Explosion in data center!"
    render json: current_user.lists, include: ['items']
  end

  def show
    render json: find_list(params[:id])
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    if @list.save
      render json: @list
    else
      render json: @list, status: 422, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  def update
    @list = find_list(params[:id])
    @list.assign_attributes(list_params)
    if @list.save
      render json: @list
    else
      render json: @list, status: 422, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  def destroy
    @list = find_list(params[:id])
    if @list && @list.destroy
      head :no_content
    else
      head :bad_request
    end
  end

  private
  def list_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params, :only => [:name, :user_id])
  end

end
