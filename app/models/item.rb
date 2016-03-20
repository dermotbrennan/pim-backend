class Item < ApplicationRecord
  belongs_to :user, required: false

  validates :name, :value, presence: true
end
