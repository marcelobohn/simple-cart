require 'rails_helper'

RSpec.describe CartProduct, type: :model do
  describe "create" do
    it "cart with product" do
      cart = Cart.create()
      p = Product.create!(name: 'nb')
      cart.cart_products.create(product: p, amount: 2, value: p.price * 2)
      expect(cart.cart_products.first.product.name).to eq('nb')
    end
  end
end
