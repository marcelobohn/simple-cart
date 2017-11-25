require 'rails_helper'

RSpec.describe "cart/index.html.erb", type: :view do
  before(:each) do
    @cart = Cart.find_by_session(session.id) || Cart.create(session: session.id)
  end

  it "renders the index cart" do
    render

    expect(rendered).to match /Cart ID/
  end
end
