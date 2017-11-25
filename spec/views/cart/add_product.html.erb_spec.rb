require 'rails_helper'

RSpec.describe "cart/_add_product.html.erb", type: :view do
  before(:each) do
    @products = Product.all
  end

  it "renders the partial form add products" do
    render :partial => "cart/add_product.html.erb"

    assert_select "form[action=?][method=?]", "/cart/add", "post" do
      assert_select "input[name=?]", "amount"
      assert_select "select[name=?]", "id"
    end
  end
end
