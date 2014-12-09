class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
  end

  # Logs-in an admin user.
  def create
    if Customer.count.zero?
      # If there's no user in the database, save given details and let it in.
      customer = Customer.create(name: params[:name], password: params[:password],
                  password_confirmation: params[:password_confirmation])
      session[:customer_id] = customer.id
      redirect_to admin_url, notice: "Welcome #{customer.name}"
    else
      # If there's any customer, details provided must be correct.
      customer = Customer.find_by(name: params[:name])
      if customer && customer.authenticate(params[:password])
        session[:customer_id] = customer.id
        redirect_to admin_url, notice: "Welcome #{customer.name}"
      else
        redirect_to login_url, alert: "Invalid user/password combination"
      end
    end
  end

  def destroy
    session[:customer_id] = nil
    redirect_to store_url, notice: "Logged out"
  end
end
