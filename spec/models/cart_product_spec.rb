require 'rails_helper'

RSpec.describe CartProduct, type: :model do
  describe "create" do
    it "cart with product" do
      cart = Cart.create(session: '672eefead958231d8e9db22c1b4d1954')
      p = Product.create!(name: 'nb')
      cart.cart_products.create(product: p, amount: 2, value: p.price * 2)
      expect(cart.cart_products.first.product.name).to eq('nb')
    end
  end
end
