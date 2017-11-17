require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "create" do
    it "default value of price" do
      product = Product.create(name: 'Bubble')
      expect(product.price).to eq 0
    end
  end
end
