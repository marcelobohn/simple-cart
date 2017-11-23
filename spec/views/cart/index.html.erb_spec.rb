require 'rails_helper'

RSpec.describe "cart/index.html.erb", type: :view do
  before(:each) do
    @cart = Cart.find_by_session(session.id) || Cart.create(session: session.id)
    @products = Product.all
  end

  it "renders the index cart" do
    render
    
    assert_select "form[action=?][method=?]", "/cart/add", "post" do
      assert_select "input[name=?]", "amount"
      assert_select "select[name=?]", "id"
    end
  end
end