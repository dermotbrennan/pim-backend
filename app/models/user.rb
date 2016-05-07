class User < ApplicationRecord
  has_secure_password

  has_many :lists

  validates :username, :name, presence: true
  validates :username, uniqueness: true
end
