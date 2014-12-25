require 'test_helper'

class CartTest < ActiveSupport::TestCase
  fixtures :carts

  test "adding different products should increase line items" do
    # Create cart
    cart = carts(:cart_1)
    # Add three different books to cart
    size, total_price = 0, 0
    [:coffee, :ruby, :rails].each do |product_name|
      product = products(product_name)
      item = cart.add_product(product.id)
      assert_in_delta item.unit_price, product.price, 0.001,
                   "cart line item price is incorrect"
      size += 1
      total_price += item.unit_price
    end
    # Ensure line_items size increases accordingly
    assert_equal size, cart.line_items.size
    # Ensure cart's total price is correct
    assert_in_delta total_price, cart.total_price, 0.001
  end

  test "adding same product should increase line item quantity" do
    # Create cart
    cart = carts(:cart_2)
    # Add the same book several times to cart
    product = products(:ruby)
    quantity = 3
    quantity.times { cart.add_product(product.id) }
    line_item = cart.line_items.find_by(product_id: product.id)
    # Ensure line_item's quantity is correct
    assert_equal quantity, line_item.quantity, "cart line item is incorrect"
    # Ensure cart's total price is correct
    assert_in_delta product.price * quantity, cart.total_price, 0.001
  end

end
