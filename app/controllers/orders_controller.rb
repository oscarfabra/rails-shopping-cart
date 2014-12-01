class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    # Avoids showing an empty cart.
    @chk_disabled = false
    if @cart.line_items.empty?
      redirect_to store_url, notice: "Your cart is empty."
      return
    end
    # Binds the order for the order#index page.
    @order = Order.new
    @chk_disabled = true
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart!(@cart)
    @order.set_payment_type_id!

    respond_to do |format|
      if @order.save!
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        OrderNotifier.received(@order).deliver

        format.html { redirect_to store_url, notice: 'Thank you for your order.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    @order = Order.find_by_id(params[:id])
    # puts "Ship date: #{params[:order][:ship_date]}"

    respond_to do |format|
      if @order.update!(order_params)
        # Sends a notification to the user if order is shipped.
        @order.ship(params[:order][:ship_date])
        # puts "ship_date updated to: #{params[:order][:ship_date]}"
        if @order.ship_date
          # puts "Sending shipped email message..."
          OrderNotifier.shipped(@order).deliver
        end


        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type, :payment_type_id)
    end
end
