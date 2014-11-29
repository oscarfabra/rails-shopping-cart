require 'test_helper'

class ErrorNotifierTest < ActionMailer::TestCase
  test "invalid_cart" do
    cart = carts(:cart_1)
    mail = ErrorNotifier.invalid_cart(cart.id)
    assert_equal "Depot App Exception: Invalid Cart", mail.subject
    assert_equal [Rails.application.secrets.admin_email], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /Invalid cart/, mail.body.encoded
  end

end
