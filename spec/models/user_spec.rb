require 'rails_helper'

RSpec.describe User, type: :model do
  describe "create" do
    it "valid value" do
      user = User.create(name: 'Martin')
      expect(user.name).to eq 'Martin'
    end
  end
end
