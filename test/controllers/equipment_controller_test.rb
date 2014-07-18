require 'test_helper'

class EquipmentControllerTest < ActionController::TestCase
  setup do
    @equipment = equipment(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:equipment)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create equipment" do
    assert_difference('Equipment.count') do
      post :create, equipment: { assigned_to: @equipment.assigned_to, buy_date: @equipment.buy_date, function: @equipment.function, location: @equipment.location, maintenance_contact: @equipment.maintenance_contact, maintenance_period: @equipment.maintenance_period, manuf_date: @equipment.manuf_date, manufacturer: @equipment.manufacturer, model: @equipment.model, name: @equipment.name, num_id: @equipment.num_id, obs: @equipment.obs, serial: @equipment.serial }
    end

    assert_redirected_to equipment_path(assigns(:equipment))
  end

  test "should show equipment" do
    get :show, id: @equipment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @equipment
    assert_response :success
  end

  test "should update equipment" do
    patch :update, id: @equipment, equipment: { assigned_to: @equipment.assigned_to, buy_date: @equipment.buy_date, function: @equipment.function, location: @equipment.location, maintenance_contact: @equipment.maintenance_contact, maintenance_period: @equipment.maintenance_period, manuf_date: @equipment.manuf_date, manufacturer: @equipment.manufacturer, model: @equipment.model, name: @equipment.name, num_id: @equipment.num_id, obs: @equipment.obs, serial: @equipment.serial }
    assert_redirected_to equipment_path(assigns(:equipment))
  end

  test "should destroy equipment" do
    assert_difference('Equipment.count', -1) do
      delete :destroy, id: @equipment
    end

    assert_redirected_to equipment_index_path
  end
end
