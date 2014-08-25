require 'test_helper'

class InterventionTypesControllerTest < ActionController::TestCase
  setup do
    @intervention_type = intervention_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:intervention_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create intervention_type" do
    assert_difference('InterventionType.count') do
      post :create, intervention_type: { name: @intervention_type.name, obs: @intervention_type.obs }
    end

    assert_redirected_to intervention_type_path(assigns(:intervention_type))
  end

  test "should show intervention_type" do
    get :show, id: @intervention_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @intervention_type
    assert_response :success
  end

  test "should update intervention_type" do
    patch :update, id: @intervention_type, intervention_type: { name: @intervention_type.name, obs: @intervention_type.obs }
    assert_redirected_to intervention_type_path(assigns(:intervention_type))
  end

  test "should destroy intervention_type" do
    assert_difference('InterventionType.count', -1) do
      delete :destroy, id: @intervention_type
    end

    assert_redirected_to intervention_types_path
  end
end
