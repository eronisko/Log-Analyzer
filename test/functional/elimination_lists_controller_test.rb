require 'test_helper'

class EliminationListsControllerTest < ActionController::TestCase
  setup do
    @elimination_list = elimination_lists(:apache_200_300)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:elimination_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create elimination_list" do
    assert_difference('EliminationList.count') do
      post :create, elimination_list: @elimination_list.attributes
    end

    assert_redirected_to elimination_list_path(assigns(:elimination_list))
  end

  test "should show elimination_list" do
    get :show, id: @elimination_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @elimination_list
    assert_response :success
  end

  test "should update elimination_list" do
    put :update, id: @elimination_list, elimination_list: @elimination_list.attributes
    assert_redirected_to elimination_list_path(assigns(:elimination_list))
  end

  test "should destroy elimination_list" do
    assert_difference('EliminationList.count', -1) do
      delete :destroy, id: @elimination_list
    end

    assert_redirected_to elimination_lists_path
  end
end
