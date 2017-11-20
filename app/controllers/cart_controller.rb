class CartController < ApplicationController

  # respond_to :html, :json

  def index
    @cart = Cart.find_by_session(session.id)
  end

  def new
    @cart = Cart.find_by_session(session.id) || Cart.create(session: session.id)
    respond_to do |format|
      format.html { redirect_to action: 'index', notice: 'Cart was successfully created.' }
      format.json { render json: @cart }
    end
  end
end
