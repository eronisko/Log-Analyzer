require 'test_helper'

class MessagePatternsControllerTest < ActionController::TestCase
  setup do
    @message_pattern = message_patterns(:client_error)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:message_patterns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create message_pattern" do
    assert_difference('MessagePattern.count') do
      post :create, message_pattern: @message_pattern.attributes
    end

    assert_redirected_to message_pattern_path(assigns(:message_pattern))
  end

  test "should show message_pattern" do
    get :show, id: @message_pattern
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @message_pattern
    assert_response :success
  end

  test "should update message_pattern" do
    put :update, id: @message_pattern, message_pattern: @message_pattern.attributes
    assert_redirected_to message_pattern_path(assigns(:message_pattern))
  end

  test "should destroy message_pattern" do
    assert_difference('MessagePattern.count', -1) do
      delete :destroy, id: @message_pattern
    end

    assert_redirected_to message_patterns_path
  end
end
