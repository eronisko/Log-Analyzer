require 'test_helper'

class IgnoreListsControllerTest < ActionController::TestCase
  setup do
    @ignore_list = ignore_lists(:apache_200_300)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ignore_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ignore_list" do
    @another_list = @ignore_list
    @another_list.name = "Something unique"
    assert_difference('IgnoreList.count') do
      post :create, ignore_list: @another_list.attributes
    end

    assert_redirected_to ignore_list_path(assigns(:ignore_list))
  end

  test "should show ignore_list" do
    get :show, id: @ignore_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ignore_list
    assert_response :success
  end

  test "should update ignore_list" do
    put :update, id: @ignore_list, ignore_list: @ignore_list.attributes
    assert_redirected_to ignore_list_path(assigns(:ignore_list))
  end

  test "should destroy ignore_list" do
    assert_difference('IgnoreList.count', -1) do
      delete :destroy, id: @ignore_list
    end

    assert_redirected_to ignore_lists_path
  end
end
