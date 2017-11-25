require 'rails_helper'

RSpec.describe "cart/_list_products.html.erb", type: :view do
  before(:each) do
    @cart = Cart.find_by_session(session.id) || Cart.create(session: session.id)
  end

  it "renders the partial list products with products price updated" do
    render :partial => "cart/list_products.html.erb", :locals => {products: @cart.cart_products, :message => 'the product price was updated'}
    expect(rendered).to match(/the product price was updated/)
  end
  
  it "renders the partial list products with products price updated" do
    render :partial => "cart/list_products.html.erb", :locals => {products: @cart.cart_products, :message => nil}
    expect(rendered).to match /Cart is empty/
  end  
  
  it "renders the partial list products with products price updated" do
    p = Product.create! name: 'Little Ruby', price: 10
    cart_product = @cart.cart_products.create! product: p, amount: 2, value: p.price
    
    render :partial => "cart/list_products.html.erb", :locals => {products: @cart.cart_products, :message => nil}
    expect(rendered).to match /Products in the cart/
    assert_select "tr>td", :text => "Little Ruby".to_s, :count => 1
    assert_select "tr>td", :text => "$20.00".to_s, :count => 2 #total product and cart
  end    
end