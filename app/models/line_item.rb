class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  # Returns the total price for associated product in associated cart.
  def total_price
    product.price * quantity
  end
end
