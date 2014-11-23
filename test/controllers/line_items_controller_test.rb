require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:li_coffee)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, product_id: products(:ruby).id
    end

    assert_redirected_to cart_path(assigns(:line_item).cart)
  end

  test "should show line_item" do
    get :show, id: @line_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_item
    assert_response :success
  end

  test "should update line_item" do
    patch :update, id: @line_item, line_item: { product_id: @line_item.product_id }
    assert_redirected_to line_item_path(assigns(:line_item))
  end

  test "should delete line_item" do
    # Tests updating to a quantity greater than 0
    assert_difference('LineItem.count', 0) do
      delete :destroy, id: @line_item, line_item: { quantity: 3 }
    end
    assert_redirected_to cart_url(@line_item.cart.id)

    # Tests updating to a negative quantity
    assert_difference('LineItem.count', 0) do
      delete :destroy, id: @line_item, line_item: { quantity: -1 }
    end
    assert_redirected_to cart_url(@line_item.cart.id)

    # Tests updating to a quantity of 0
    assert_difference('LineItem.count', -1) do
      delete :destroy, id: @line_item, line_item: { quantity: 0 }
    end
    assert_redirected_to cart_url(@line_item.cart.id)
  end
end
