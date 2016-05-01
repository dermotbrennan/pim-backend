class ListSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :user_id
  has_many :items
end
