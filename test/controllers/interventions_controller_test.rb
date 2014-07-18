require 'test_helper'

class InterventionsControllerTest < ActionController::TestCase
  setup do
    @intervention = interventions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:interventions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create intervention" do
    assert_difference('Intervention.count') do
      post :create, intervention: { changed_parts: @intervention.changed_parts, day: @intervention.day, description: @intervention.description, eq_hours: @intervention.eq_hours, equipment_id: @intervention.equipment_id, estimate_num: @intervention.estimate_num, labor_cost: @intervention.labor_cost, maintainer: @intervention.maintainer, parts_cost: @intervention.parts_cost, preventive: @intervention.preventive, purchase_num: @intervention.purchase_num, repair: @intervention.repair, task_num: @intervention.task_num }
    end

    assert_redirected_to intervention_path(assigns(:intervention))
  end

  test "should show intervention" do
    get :show, id: @intervention
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @intervention
    assert_response :success
  end

  test "should update intervention" do
    patch :update, id: @intervention, intervention: { changed_parts: @intervention.changed_parts, day: @intervention.day, description: @intervention.description, eq_hours: @intervention.eq_hours, equipment_id: @intervention.equipment_id, estimate_num: @intervention.estimate_num, labor_cost: @intervention.labor_cost, maintainer: @intervention.maintainer, parts_cost: @intervention.parts_cost, preventive: @intervention.preventive, purchase_num: @intervention.purchase_num, repair: @intervention.repair, task_num: @intervention.task_num }
    assert_redirected_to intervention_path(assigns(:intervention))
  end

  test "should destroy intervention" do
    assert_difference('Intervention.count', -1) do
      delete :destroy, id: @intervention
    end

    assert_redirected_to interventions_path
  end
end
