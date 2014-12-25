class SessionsController < ApplicationController
  include CurrentCart
  before_action :set_cart # Guarantees that cart is going to be shown.
  skip_before_action :authorize


  def new
  end

  # Logs-in a customer or admin user.
  def create
    # Details provided must be correct.
    customer = Customer.find_by(email: params[:email])
    if customer && customer.authenticate(params[:password])
      session[:customer_id] = customer.id
      redirect_to admin_url, notice: "Welcome #{customer.firstname}"
    else
      redirect_to login_url, alert: "Invalid email/password combination"
    end
  end

  def destroy
    session[:customer_id] = nil
    redirect_to store_url, notice: "Logged out"
  end
end
