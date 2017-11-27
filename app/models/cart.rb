class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_products
  validates :session, presence: true
  
  def expired?
    self.updated_at > (Date.today-2) 
  end
end
