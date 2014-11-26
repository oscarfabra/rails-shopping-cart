class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  # Adds a product to cart. Creates a new LineItem if it doesn't exist yet.
  def add_product(product_id)
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
      current_item.price = current_item.product.price
      line_items << current_item
    end
    current_item.save!
    current_item
  end

  # Decrements quantity of line_item. Destroys if quantity is zero.
  def decrement_line_item_quantity(line_item_id)
    current_item = line_items.find(line_item_id)

    if current_item.quantity > 1
      current_item.quantity -= 1
    else
      current_item.destroy
    end

    current_item
  end

  # Returns total price for all items in this cart.
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end
