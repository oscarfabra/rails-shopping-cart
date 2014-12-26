require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  setup do
    @customer = customers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      post :create, customer: {
                      firstname: 'Dave',
                      lastname: 'Depot',
                      email: 'dave@example.org',
                      password: 'secret123',
                      password_confirmation: 'secret123' }
    end

    assert_redirected_to admin_path
  end

  test "should show customer" do
    get :show, id: @customer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer
    assert_response :success
  end

  test "should update customer" do
    patch :update, id: @customer,
          customer: {
              firstname: @customer.firstname,
              lastname: @customer.lastname,
              email: @customer.email,
              password: 'secret123',
              password_confirmation: 'secret123' }

    assert_response :success
  end

  test "should destroy customer" do
    assert_difference('Customer.count', -1) do
      delete :destroy, id: 2  # A different customer
    end

    assert_redirected_to customers_path
  end
end
