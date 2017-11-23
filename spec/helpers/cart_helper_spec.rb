require 'rails_helper'
RSpec.describe CartHelper, type: :helper do
  describe "#format_value" do
    it "currency format in view" do
      expect(helper.format_value(1)).to eq("$1.00")
      expect(helper.format_value(10000)).to eq("$10,000.00")
    end
  end  
end
