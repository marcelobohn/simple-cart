class User < ApplicationRecord
  has_many :cart
  validates :name, presence: true
end
