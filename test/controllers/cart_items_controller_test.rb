require 'test_helper'

class CartItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get orders_create_url
    assert_response :success
  end

  test "should get update" do
    get orders_update_url
    assert_response :success
  end

  test "should get destroy" do
    get orders_destroy_url
    assert_response :success
  end

end
