require 'rails_helper'

RSpec.describe CartController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns redirect" do
      get :new
      expect(response).to redirect_to "/cart?notice=Cart+was+successfully+created."
    end

    it "returns json" do
      get :new, format: :json
      expect(response).to have_http_status(:success)
      json_body = JSON.parse(response.body)
      expect(json_body["session"]).not_to be_empty
    end
  end

end
