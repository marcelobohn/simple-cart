class Product < ApplicationRecord
  validates :name, presence: true
  after_initialize :default_values

  private
    def default_values
      self.price ||= 0
    end
end
