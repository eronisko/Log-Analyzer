require 'test_helper'

class SourcesControllerTest < ActionController::TestCase
  setup do
    @source = sources(:apache_combined_errors)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create source" do
    @source.name = "A unique name"
    assert_difference('Source.count') do
      post :create, source: @source.attributes
    end

    assert_redirected_to source_path(assigns(:source))
  end

  test "should show source" do
    get :show, id: @source
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @source
    assert_response :success
  end

  test "should update source" do
    put :update, id: @source, source: @source.attributes
    assert_redirected_to source_path(assigns(:source))
  end

  test "should destroy source and associated message patterns" do
    assert_difference('Source.count', -1) do
      assert @source.extraction_patterns.count > 0,
                                  "There are no patterns for @sources. " +
                                  "That makes this test pointless..."
      
      assert_difference('MessagePattern.count', -1 * (@source.message_patterns.count)) do
        delete :destroy, id: @source
      end
    end

    assert_redirected_to sources_path
  end
end
