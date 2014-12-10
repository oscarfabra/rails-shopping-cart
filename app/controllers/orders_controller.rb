require 'rest_client' # Using RestClient library.


class OrdersController < ApplicationController

  include CurrentCart
  include CurrentOrder
  before_action :set_cart # Guarantees that cart is going to be shown.
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    # Retrieves orders from current customer ordered by created_at date.
    @orders = Order.where(customer_id: session[:customer_id]).order(:created_at)
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

    # Binds the order for the order#index page and gets some attributes.
    @order = Order.new
    @order.order_no = get_order_no
    set_customer_details(@order)
    @order.total = @cart.total_price

    # Disables the checkout btn.
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
      if @order.errors.empty? && @order.save
        # Deletes cart.
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

        # Sends 'order received' e-mail notification to client.
        OrderNotifier.received(@order).deliver

        # Sends orders details in json format to dummy payment gateway via post.
        RestClient.post "http://localhost:3001/read_order", order_params.to_json,
                        :content_type => :json, :accept => :json

        response = RestClient.get "http://localhost:3001/payments"

        pay_notice = ''
        case response
          when 200
            pay_notice = 'Payment was received successfully.'
          else
            pay_notice = 'Unfortunately, payment was not received.'
        end

        format.html { redirect_to store_url, notice: "Thank you for your order! #{pay_notice}" }
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

    # Never trust parameters from internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:total,
                                    :customer_id,
                                    :order_no,
                                    :address,
                                    :email,
                                    :pay_type,
                                    :payment_type_id,
                                    :ship_date)
    end
end
