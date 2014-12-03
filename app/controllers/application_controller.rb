class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception

  # Causes the authorize method to be called before every action in application.
  before_action :authorize

  protected
    def authorize
      # Selects authorization method depending on request format.
      if request.format == Mime::HTML
        user = User.find_by(id: session[:user_id])
        # If user wasn't found, redirect to login.
        redirect_to login_url, notice: "Please log in" unless user
      else
        authenticate_or_request_with_http_basic do |username, password|
          user = User.find_by(name: username)
          user && user.authenticate(password)
        end
      end
    end
end
