require 'test_helper'

class MobileDevicesControllerTest < ActionController::TestCase
  setup do
    @mobile_device = mobile_devices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mobile_devices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mobile_device" do
    assert_difference('MobileDevice.count') do
      post :create, mobile_device: {  }
    end

    assert_redirected_to mobile_device_path(assigns(:mobile_device))
  end

  test "should show mobile_device" do
    get :show, id: @mobile_device
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mobile_device
    assert_response :success
  end

  test "should update mobile_device" do
    patch :update, id: @mobile_device, mobile_device: {  }
    assert_redirected_to mobile_device_path(assigns(:mobile_device))
  end

  test "should destroy mobile_device" do
    assert_difference('MobileDevice.count', -1) do
      delete :destroy, id: @mobile_device
    end

    assert_redirected_to mobile_devices_path
  end
end
