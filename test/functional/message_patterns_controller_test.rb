require 'test_helper'

class MessagePatternsControllerTest < ActionController::TestCase
  setup do
    @message_pattern = message_patterns(:client_error)
    @source = sources(:apache_combined_errors)
  end

  test "should get new" do
    get :new, source_id: @source
    assert_response :success
  end

  test "should create message_pattern" do
    @message_pattern.name = "a unique name"
    assert_difference('MessagePattern.count') do
      post :create, message_pattern: @message_pattern.attributes,
                    source_id: @source
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

    assert_redirected_to source_message_patterns_path(assigns(:message_pattern).source)
  end
end
