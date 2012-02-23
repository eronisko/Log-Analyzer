require 'test_helper'

class LogsControllerTest < ActionController::TestCase
  setup do
    @log           = logs(:web_server)
    @investigation = investigations(:flower_shop)
  end

  test "should get index" do
    get :index, investigation_id: @investigation
    assert_response :success
    assert_not_nil assigns(:logs)
  end

  test "should get new" do
    get :new, investigation_id: @investigation
    assert_response :success
  end

  test "should create log" do
    @another_log = Log.new(investigation: @investigation,
                           name: "yet another log",
                           description: "taken from a boat",
                           data_type: "plaintext",
                           path: "yet/another/path",
                           time_bias: 0
                          )

    assert_difference('Log.count') do
      post :create, log: @another_log.attributes
    end

    assert_redirected_to log_path(assigns(:log))
  end

  test "should show log" do
    get :show, investigation_id: @investigation, id: @log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @log
    assert_response :success
  end

  test "should update log" do
    put :update, id: @log, log: @log.attributes
    assert_redirected_to log_path(assigns(:log))
  end

  test "should destroy log" do
    assert_difference('Log.count', -1) do
      delete :destroy, id: @log
    end

    assert_redirected_to investigation_logs_path(@log.investigation)
  end
end
