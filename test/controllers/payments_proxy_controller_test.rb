require 'test_helper'

class PaymentsProxyControllerTest < ActionController::TestCase
  test "should get make_payment" do
    get :make_payment
    assert_response :success
  end

  test "should get read_response" do
    get :read_response
    assert_response :success
  end

end
