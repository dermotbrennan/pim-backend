class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :value, :image_thumb_url, :image_medium_url

  def image_thumb_url
    object.image.url(:thumb)
  end

  def image_medium_url
    object.image.url(:medium)
  end
end
