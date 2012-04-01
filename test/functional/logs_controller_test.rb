require 'test_helper'

class LogsControllerTest < ActionController::TestCase
  setup do
    @investigation = investigations(:flower_shop)
    @log = logs(:web_server)
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
                           message_delimiter: '\n',
                           file: 'my_log'
                          )

    assert_difference('Log.count') do
      assert_difference('LogMessage.count',7) do
        log_params = @another_log.attributes
        log_params["uploaded_file"] = upload_file
        post :create, log: log_params,
                      investigation_id: @another_log.investigation_id
      end
    end

    assert_redirected_to log_path(assigns(:log))
  end

  test "should show log" do
    get :show, id: @log
    assert_response :success

    assert_select "div#ignore_list_selector"
    assert_select "div#source_selector"
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
    @ignore_list = ignore_lists(:apache_200_300)
    log_params = @log.attributes
    log_params["applied_ignore_list"] = @ignore_list

    assert_difference ('@log.log_messages.ignored.count') do
      put :update, id: @log, log: log_params
    end
    assert_equal @ignore_list, Log.find(@log).ignore_list
  end

  #test "apply_source should reset all the extraction fields at start"
  test "should apply a source" do
    @source = sources(:apache_combined_errors)

    log_params = @log.attributes
    log_params["applied_source"] = @source

    assert_difference ('@log.log_messages.matched.count') do
      put :update, id: @log, log: log_params
    end
    assert_equal @source, Log.find(@log).source
  end
end
