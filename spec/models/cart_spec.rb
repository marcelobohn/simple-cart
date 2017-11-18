require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "create" do
    it "simple values" do
      user = User.create!(name: 'rick')
      cart = Cart.create(user: user)
      expect(cart.user.name).to eq('rick')
    end
  end
end
