class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
  end

  # Logs-in an admin user.
  def create
    if User.count.zero?
      # If there's no user in the database, save given details and let it in.
      user = User.create(name: params[:name], password: params[:password],
                  password_confirmation: params[:password_confirmation])
      session[:user_id] = user.id
      redirect_to admin_url, notice: "Welcome #{user.name}"
    else
      # If there's any user, details provided must be correct.
      user = User.find_by(name: params[:name])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to admin_url, notice: "Welcome #{user.name}"
      else
        redirect_to login_url, alert: "Invalid user/password combination"
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: "Logged out"
  end
end
