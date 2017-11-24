class CartController < ApplicationController
  before_action :set_cart, except: [:remove]

  def index
    @products = Product.all
    respond_to do |format|
      format.html
      format.json { render json: { cart: @cart, message: @message } }
    end
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
      cart_product = @cart.cart_products.create! product: product, amount: params[:amount].to_i, value: product.price

      respond_to do |format|
        format.json { render json: cart_product }
        format.js { render 'cart/list_products.js.erb' }
      end
    else
      render json: { error: 'Product not found' }
    end
  end

  def update
    cart_product = @cart.cart_products.find_by_id params[:id]
    if !cart_product.nil?
      @message = 'the product price was updated' if cart_product.value != cart_product.product.price
      cart_product.update! amount: params[:amount].to_i, value: cart_product.product.price
      respond_to do |format|
        format.json { render json: { cart_product: cart_product, message: @message || '' } }
        format.js { render 'cart/list_products.js.erb' }
      end
    else
      render json: { error: 'Product not found' }
    end
  end

  def remove
    cart_product = CartProduct.find_by_id params[:id]
    if !cart_product.nil?
      @cart = Cart.find(cart_product.cart.id)
      cart_product.delete
      respond_to do |format|
        format.json { render json: { message: 'Product removed' } }
        format.js { render 'cart/list_products.js.erb' }
      end
    else
      render json: { error: 'Product not found' }
    end
  end

  private
    def set_cart
      if not session.id.nil?
        @cart = Cart.find_by_session(session.id) || Cart.create(session: session.id)
        if not @cart.is_valid?
          @cart.cart_products.map{|a| a.delete}
          @cart.delete
          @cart = nil
          @message = 'Cart was expired' 
        end
      end
    end

end
