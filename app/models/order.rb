class Order < ActiveRecord::Base

  has_many :line_items, dependent: :destroy

  # Constant array shown to user as a drop-down list.
  PAYMENT_TYPES = PaymentType.select(:pay_name).map(&:pay_name)

  # Validates that form values are appropriate.
  validates :name, :address, :email, :payment_type_id, presence: true
  validates_presence_of :pay_type

  # Adds a line_item from cart into an order instance.
  def add_line_items_from_cart!(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  # Sets the payment_type_id attribute according to pay_type.
  def set_payment_type_id!
    case self.pay_type
      when 'Check'
        self.payment_type_id = 1
      when 'Credit card'
        self.payment_type_id = 2
      when 'Purchase order'
        self.payment_type_id = 3
    end
  end
end
