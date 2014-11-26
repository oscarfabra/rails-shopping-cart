class Order < ActiveRecord::Base

  has_many :line_items, dependent: :destroy

  # Constant array shown to user as a drop-down list.
  PAYMENT_TYPES = ["Check", "Credit card", "Purchase order"]

  # Validates that form values are appropriate.
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES

  # Adds a line_item from cart into an order instance.
  def add_line_items_from_cart!(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
