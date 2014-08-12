require 'test_helper'

class MaintasksControllerTest < ActionController::TestCase
  setup do
    @maintask = maintasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:maintasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create maintask" do
    assert_difference('Maintask.count') do
      post :create, maintask: { equipment_id: @maintask.equipment_id, period: @maintask.period, task: @maintask.task, unit: @maintask.unit }
    end

    assert_redirected_to maintask_path(assigns(:maintask))
  end

  test "should show maintask" do
    get :show, id: @maintask
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @maintask
    assert_response :success
  end

  test "should update maintask" do
    patch :update, id: @maintask, maintask: { equipment_id: @maintask.equipment_id, period: @maintask.period, task: @maintask.task, unit: @maintask.unit }
    assert_redirected_to maintask_path(assigns(:maintask))
  end

  test "should destroy maintask" do
    assert_difference('Maintask.count', -1) do
      delete :destroy, id: @maintask
    end

    assert_redirected_to maintasks_path
  end
end
