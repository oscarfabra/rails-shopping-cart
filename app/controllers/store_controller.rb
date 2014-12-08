class StoreController < ApplicationController
  skip_before_action :authorize

  include CurrentCart
  before_action :set_cart

  def index
    if params[:set_locale]
      # Redirects to the corresponding locale.
      redirect_to store_url(locale: params[:set_locale])
    else
      # Retrieves products with status = 1, ordered by name.
      @products = Product.order(:name).where(status: 1)
      if session[:counter].nil?
        session[:counter] = 1
      else
        session[:counter] += 1
      end
    end
  end
end
