require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "create" do
    it "cart with user" do
      user = User.create!(name: 'rick')
      cart = Cart.create(session: '672eefead958231d8e9db22c1b4d1954', user: user)
      expect(cart.user.name).to eq('rick')
    end

    it "cart don't have user" do
      cart = Cart.create(session: '672eefead958231d8e9db22c1b4d1954')
      expect(cart.created_at.strftime("%Y-%m-%d")).to eq(Date.today.strftime("%Y-%m-%d"))
    end
  end
  
 describe "#expired" do
    it "cart is not expired" do
      cart = Cart.create(session: '672eefead958231d8e9db22c1b4d1954')
      expect(cart.expired?).to be true
    end
   
    it "cart is expired" do
      cart = Cart.create(session: '672eefead958231d8e9db22c1b4d1954')
      cart.update(updated_at: Date.today-3)
      expect(cart.expired?).to be false
    end   
 end
  
end
