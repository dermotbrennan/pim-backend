class ItemsController < ApplicationController
  #  before_action :authenticate

  def index
    render json: Item.all
  end

  def show
    render json: Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      render json: @item
    else
      render json: @item, status: 422, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  def update
    @item = Item.find(params[:id])
    # logger.debug(params.inspect)
    # logger.debug(params[:data])
    # logger.debug(params[:image])
    # logger.debug(request.raw_post)
    # logger.debug(item_params)
    @item.assign_attributes(item_params)
    if params[:image].present?
      @item.image = params[:image]
    end

    if @item.save
      render json: @item
    else
      render json: @item, status: 422, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      head :no_content
    else
      head :bad_request
    end
  end

  private
    def json_params
      ja = json_attributes()
      js = ja.dup
      js.each do |k, v|
        if k.to_s.include?('-')
          ja.delete(k)
          ja[k.to_s.gsub('-', '_').to_sym] = v
        end
      end

      pms = ActionController::Parameters.new(ja)
   end

   def json_attributes
     logger.debug(payload_hsh.to_s)
     ActiveModelSerializers::Deserialization.jsonapi_parse!(payload_hsh)
   end

   def payload_hsh
    #  hsh = JSON.parse(request.raw_post)
    {"data" => JSON.parse(params[:data])}
   end

   def item_params
     json_params.permit(:name, :value, :image)
   end

end
