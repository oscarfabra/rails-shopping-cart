require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Depot App Order Confirmation", mail.subject
    assert_equal ["user@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /Programming Ruby 1.9/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Depot App Order Shipped", mail.subject
    assert_equal ["user@example.org"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /Programming Ruby 1.9/, mail.body.encoded
  end

end
