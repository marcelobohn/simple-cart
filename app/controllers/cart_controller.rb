class CartController < ApplicationController
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

  def add
    cart = Cart.find_by_session(session.id) || Cart.create(session: session.id)
    product = Product.find params[:id]
    @product = cart.cart_products.create! product: product, amount: params[:amount].to_i, value: product.price * params[:amount].to_i
    render json: @product
  end
end
