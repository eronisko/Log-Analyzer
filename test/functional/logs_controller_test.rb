require 'test_helper'

class LogsControllerTest < ActionController::TestCase
  setup do
    @log           = logs(:web_server)
    @investigation = investigations(:flower_shop)
  end

  test "should get new" do
    get :new, investigation_id: @investigation
    assert_response :success
  end

  test "should create log" do
    upload_file   = fixture_file_upload('files/flower_shop_log.log',
                                         'application/octet-stream')
    @another_log = Log.new(investigation: @investigation,
                           name: "yet another log",
                           description: "taken from a boat",
                           data_type: "plaintext",
                           time_bias: 0,
                           file: 'my_log'
                          )

    assert_difference('Log.count') do
      log_params = @another_log.attributes
      log_params["uploaded_file"] = upload_file
      post :create, log: log_params,
                    investigation_id: @another_log.investigation_id

    end

    assert_redirected_to log_path(assigns(:log))
  end

  test "should show log" do
    get :show, investigation_id: @investigation, id: @log
    assert_response :success

    assert_select "div#ignore_list_selector"
  end


  test "should get edit" do
    get :edit, id: @log
    assert_response :success
  end

  test "should update log" do
    put :update, id: @log, log: @log.attributes
    assert_redirected_to log_path(assigns(:log))
  end

  test "should destroy log and associated messages" do
    assert_difference('Log.count', -1) do
      assert @log.log_messages.count > 0, "There are no messages for @log." +
                                          " That makes the test pointless"

      assert_difference('LogMessage.count', -1 * (@log.log_messages.count)) do
        delete :destroy, id: @log
      end
    end

    assert_redirected_to investigation_path(@log.investigation)
  end

  test "should apply an ignore list" do
    @pattern_list = ignore_lists(:apache_200_300)

    assert_difference ('@log.log_messages.ignored.count') do
      put :filter, id: @log, ignore_list: @pattern_list
    end
  end
end
