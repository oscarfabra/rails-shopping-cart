require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  # A user goes to the index page. They select a product, adding it to their
  # cart, and check out, filling in their details on the checkout form. When
  # they submit, an order is created containing their information, along with a
  # single line item corresponding to the product they added to their cart.
  test "buying a product" do

    # Empties LineItem, Order. Gets ruby_book from fixtures.
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)

    # Visit the store index.
    get "/"
    assert_response :success
    assert_template "index"

    # Add ruby_book to the cart via ajax.
    xml_http_request :post, '/line_items', product_id: ruby_book.id
    assert_response :success

    # Guarantee cart now contains the added line_item with the ruby_book.
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product

    # Visit the checkout page.
    get "/orders/new"
    assert_response :success
    assert_template "new"

    # Post an order with the given details and guarantee redirected to index.
    post_via_redirect "/orders", order: {
                               name: "Dave Thomas",
                               address: "123 The Street",
                               email: "dave@example.com",
                               pay_type: "Check" }
    assert_response :success
    assert_template "index"

    # Check that cart was emptied.
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    # Check order was stored in the database.
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]

    # Check that first order is the expected one.
    assert_equal "Dave Thomas",     order.name
    assert_equal "123 The Street",  order.address
    assert_equal "dave@example.com",order.email
    assert_equal "Check",           order.pay_type

    # Check that line_items contains the expected product.
    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product

    # Check that order confirmation mail was delivered.
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'Depot App <depot@example.com>', mail[:from].value
    assert_equal "Depot App Order Confirmation", mail.subject
  end

  # Tests that when an order's ship date is set via an update, a shipped email
  # is delivered. Builds upon the "buying a product" test.
  test "admin can update order ship_date" do

    # Empties LineItem, Order. Gets ruby_book from fixtures.
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)

    # Visit the store index.
    get "/"
    assert_response :success
    assert_template "index"

    # Add ruby_book to the cart via ajax.
    xml_http_request :post, '/line_items', product_id: ruby_book.id
    assert_response :success

    # Guarantee cart now contains the added line_item with the ruby_book.
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product

    # Visit the checkout page.
    get "/orders/new"
    assert_response :success
    assert_template "new"

    # Post an order with the given details. Guarantee redirected to index and
    # cart is emptied.
    post_via_redirect "/orders", order: {
                                   name: "Dave Thomas",
                                   address: "123 The Street",
                                   email: "dave@example.com",
                                   pay_type: "Credit card",
                                   payment_type_id: 2 }
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    # Check order was stored in the database.
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]

    # Check that first order is the expected one.
    assert_equal "Dave Thomas",     order.name
    assert_equal "123 The Street",  order.address
    assert_equal "dave@example.com",order.email
    assert_equal "Credit card",     order.pay_type

    # THE UPDATE PART.

    # Visit order edit page.
    get "/orders/#{order.id}/edit"
    assert_response :success
    assert_template "edit"

    # Update (patch) order with details that include ship_date.
    ship_date = Time.now
    patch_via_redirect "/orders/#{order.id}",
                       order: {
                           name: "Dave Thomas",
                           address: "123 The Street",
                           email: "dave@example.com",
                           pay_type: "Check",
                           payment_type_id: 1,
                           ship_date: ship_date }
    assert_response :success
    assert_template "index"

    # Check that cart is empty.
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    # Check order is stored in the database.
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]
    # puts "ship_date: #{Order.first.ship_date}"
    
    # Check that first order is the expected one.
    assert_equal "Dave Thomas",     order.name
    assert_equal "123 The Street",  order.address
    assert_equal "dave@example.com",order.email
    assert_equal "Check",           order.pay_type
    assert_equal 1,                 order.payment_type_id
    # assert_equal ship_date,         order.ship_date

    # Check that line_items contains the expected product.
    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product

    # Check that order shipped mail was delivered.
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'Depot App <depot@example.com>', mail[:from].value
    assert_equal "Depot App Order Shipped", mail.subject
  end

  test "" do

  end
end
