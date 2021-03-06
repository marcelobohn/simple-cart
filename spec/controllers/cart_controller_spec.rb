require 'rails_helper'

RSpec.describe CartController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns cart expired" do
      get :index
      expect(response).to have_http_status(:success)

      # make the cart to expired
      Cart.find_by_session(session.id).update!(updated_at: Date.today - 3)

      get :index, format: :json
      json_body = JSON.parse(response.body)
      expect(json_body["message"]).to eq "Cart was expired"
    end
  end

  describe "GET #new" do
    it "returns redirect" do
      get :new
      expect(response).to redirect_to "/?notice=Cart+was+successfully+created."
    end

    it "returns json" do
      get :new, format: :json
      json_body = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json_body["session"]).not_to be_empty
    end
  end

  describe "POST #add" do
    let!(:product) { Product.create! name: 'Little Ruby', price: 10 }

    it "add product in cart" do
      post :add, format: :json, params: { id: product.id, amount: 5 }
      expect(response).to have_http_status(:success)
      json_body = JSON.parse(response.body)

      expect(json_body["value"]).not_to be_empty
      expect(json_body["value"].to_f * json_body["amount"].to_f).to be 50.0
    end

    it "try add not exists product" do
      post :add, format: :json, params: { id: 0, amount: 5 }
      json_body = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json_body["error"]).to eq "Product not found"
    end
  end

  describe "POST #update" do
    let!(:product) { Product.create! name: 'Little Ruby', price: 10 }
    let!(:cart) { Cart.find_by_session(session.id) || Cart.create(session: session.id) }
    let!(:cart_product) { cart.cart_products.create!(product: product, amount: 2, value: product.price) }

    it "update product in cart" do
      post :update, format: :json, params: { id: cart_product.id, amount: 10 }
      json_body = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json_body["cart_product"]["value"]).not_to be_empty
      expect(json_body["cart_product"]["value"].to_f * json_body["cart_product"]["amount"].to_f).to be 100.0
      expect(json_body["message"]).to be_empty
    end

    it "update product in cart" do
      product.update price: 20
      post :update, format: :json, params: { id: cart_product.id, amount: 10 }
      json_body = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json_body["cart_product"]["value"]).not_to be_empty
      expect(json_body["cart_product"]["value"].to_f * json_body["cart_product"]["amount"].to_f).to be 200.0
      expect(json_body["message"]).to eq "the product price was updated"
    end
    

    it "update product not found" do
      product.update price: 20
      post :update, format: :json, params: { id: 0, amount: 10 }
      json_body = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json_body["error"]).to eq "Product not found"
    end    
  end

  describe "POST #remove" do
    before {
      cart.cart_products.create!(product: product, amount: 2, value: product.price * 2)
    }

    let!(:product) { Product.create! name: 'Little Ruby', price: 10 }
    let!(:cart) { cart = Cart.find_by_session(session.id) || Cart.create(session: session.id) }

    it "remove product in cart" do
      post :remove, format: :json, params: { id: cart.cart_products.first.id }
      json_body = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json_body["message"]).to eq "Product removed"
    end
    
    it "remove product in cart" do
      post :remove, format: :json, params: { id: 0 }
      json_body = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(json_body["error"]).to eq "Product not found"
    end    
  end

end
