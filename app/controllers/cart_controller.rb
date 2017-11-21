class CartController < ApplicationController
  before_action :set_cart

  def index
  end

  def new
    respond_to do |format|
      format.html { redirect_to action: 'index', notice: 'Cart was successfully created.' }
      format.json { render json: @cart }
    end
  end

  def add
    product = Product.find_by_id params[:id]
    if !product.nil?
      cart_product = @cart.cart_products.create! product: product, amount: params[:amount].to_i, value: product.price * params[:amount].to_i
      render json: cart_product
    else
      render json: { error: 'Product not found' }
    end
  end

  def update
    product = Product.find_by_id params[:id]
    cart_product = @cart.cart_products.find_by_id params[:id]
    if !product.nil? and !cart_product.nil?
      cart_product.update! amount: params[:amount].to_i, value: product.price * params[:amount].to_i
      render json: cart_product
    else
      render json: { error: 'Product not found' }
    end
  end


  private
    def set_cart
      @cart = Cart.find_by_session(session.id) || Cart.create(session: session.id)
    end

end
