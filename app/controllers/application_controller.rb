class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception

  # Causes the authorize method to be called before every action in application.
  before_action :authorize
  before_action :set_i18n_locale_from_params

  protected
    def authorize
      # Nothing to authorize.
      return if Customer.count.zero?
      # Selects authorization method depending on request format.
      if request.format == Mime::HTML || request.format == MIME::JS
        customer = Customer.find_by(id: session[:customer_id])
        # If customer wasn't found, redirect to login.
        redirect_to login_url, notice: "Please log in" unless customer
      else
        authenticate_or_request_with_http_basic do |username, password|
          customer = Customer.find_by(name: username)
          customer && customer.authenticate(password)
        end
      end
    end

    # Sets the locale from the params if it is set.
    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end

    # Default url options.
    def default_url_options
      { locale: I18n.locale }
    end
end
