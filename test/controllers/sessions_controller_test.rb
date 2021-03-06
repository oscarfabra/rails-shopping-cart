require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    dave = customers(:one)
    post :create, firstname: dave.firstname, lastname: dave.lastname,
         email: dave.email, password: 'secret'
    assert_redirected_to admin_url
    assert_equal dave.id, session[:customer_id]
  end

  test "should fail login" do
    dave = customers(:one)
    post :create, firstname: dave.firstname, lastname: dave.lastname,
         email: dave.email, password: 'wrong'
    assert_redirected_to login_url
  end

  test "should logout" do
    delete :destroy
    assert_redirected_to store_url
  end

end
