class Product < ApplicationRecord
  has_many :cart_products
  validates :name, presence: true
  after_initialize :default_values

  private
    def default_values
      self.price ||= 0
    end
end
