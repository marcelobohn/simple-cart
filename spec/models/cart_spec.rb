require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "create" do
    it "cart with user" do
      user = User.create!(name: 'rick')
      cart = Cart.create(user: user)
      expect(cart.user.name).to eq('rick')
    end

    it "cart don't have user" do
      cart = Cart.create()
      expect(cart.created_at.strftime("%Y-%m-%d")).to eq(Date.today.strftime("%Y-%m-%d"))
    end
  end
end
