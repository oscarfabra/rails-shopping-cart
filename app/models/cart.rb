class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  # Adds a product to cart. Create a new LineItem if it doesn't exist yet.
  def add_product(product_id)
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
    end
    current_item
  end

  # Returns total price for all items in this cart.
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
