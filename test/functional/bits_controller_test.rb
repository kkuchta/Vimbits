require 'test_helper'

class BitsControllerTest < ActionController::TestCase
  setup do
    @bit = bits(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bits)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bit" do
    assert_difference('Bit.count') do
      post :create, bit: @bit.attributes
    end

    assert_redirected_to bit_path(assigns(:bit))
  end

  test "should show bit" do
    get :show, id: @bit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bit
    assert_response :success
  end

  test "should update bit" do
    put :update, id: @bit, bit: @bit.attributes
    assert_redirected_to bit_path(assigns(:bit))
  end

  test "should destroy bit" do
    assert_difference('Bit.count', -1) do
      delete :destroy, id: @bit
    end

    assert_redirected_to bits_path
  end
end
