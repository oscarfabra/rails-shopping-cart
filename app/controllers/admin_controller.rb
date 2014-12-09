class AdminController < ApplicationController

  include CurrentUser
  include CurrentCart
  before_action :set_cart # Guarantees that cart is going to be shown.

  def index
    if !user_logged_in
      redirect_to login_path
    end
    @total_orders = Order.where(customer_id: session[:customer_id]).count
  end
end
