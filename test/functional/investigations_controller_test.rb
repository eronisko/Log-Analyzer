require 'test_helper'

class InvestigationsControllerTest < ActionController::TestCase
  setup do
    @investigation = investigations(:flower_shop)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:investigations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create investigation" do
    @another_investigation = Investigation.new(
        name:        "My new investigation",
        description: "my new description")

    assert_difference('Investigation.count') do
      post :create, investigation: @another_investigation.attributes
    end

    assert_redirected_to investigation_path(assigns(:investigation))
  end

  test "should show investigation" do
    get :show, id: @investigation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @investigation
    assert_response :success
  end

  test "should update investigation" do
    put :update, id: @investigation, investigation: @investigation.attributes
    assert_redirected_to investigation_path(assigns(:investigation))
  end

  test "should destroy investigation and associated logs" do
    assert_difference('Investigation.count', -1) do
      assert_difference('Log.count', -1 * (@investigation.logs.count)) do
        delete :destroy, id: @investigation
      end
    end

    assert_redirected_to investigations_path
  end
end
