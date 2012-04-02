require 'test_helper'

class LogTest < ActiveSupport::TestCase
  setup do
    @log = logs(:web_server)
    @new_log = Log.new(investigation: investigations(:flower_shop),
                       name: 'Database Log',
                       description: 'MySQL database server',
                       data_type: 'plaintext',
                       file: 'test/fixtures/flower_shop_log.log',
                       message_delimiter: '\n',
                       time_bias: 0
                      )
    @ignore_list = ignore_lists(:apache_200_300)
    @source = sources(:apache_combined_errors) 
  end

  test "log names have to be unique within an investigation" do
    @new_log.name = logs(:web_server).name
    assert !@new_log.save, 'Successfully saved a duplicate log'
  end

  test "log names can repeat across different investigations" do
    different_log                   = @new_log 
    different_log.name              = logs(:web_server).name
    different_log.investigation     = investigations(:uob_manufacturing)

    assert different_log.save
  end
  
  test "has to have an investigation" do
    @new_log.investigation = nil
    assert !@new_log.save
  end

  test "has to have a name" do
    @new_log.name = nil
    assert !@new_log.save
  end
  
  test "has to have a data type" do
    @new_log.data_type = nil
    assert !@new_log.save
  end
  
  test "has to have a file uploaded" do
    @new_log.file = nil
    assert !@new_log.save
  end
  
  test "has to have a valid time bias" do
    @new_log.time_bias = nil
    assert !@new_log.save

    @new_log.time_bias = 'hello'
    assert !@new_log.save
  end

  test "has to have a message_delimiter which can be blank, but not nil" do
    @new_log.message_delimiter = nil
    assert !@new_log.save
    @new_log.message_delimiter = '\n'
    assert @new_log.save
  end

  test "applied_ignore_list should ignore matching the messages" do
    assert_difference ('@log.log_messages.ignored.count') do
      @log.applied_ignore_list=@ignore_list.id.to_s
    end
  end

  test "applied_ignore_list=nil should unignore all the messages" do
    @log.applied_ignore_list=@ignore_list.id.to_s
    assert_difference ('@log.log_messages.active.count') do
      @log.applied_ignore_list=""
    end
  end

  test "applied_source should extract matching the messages" do
    assert_difference ('@log.log_messages.matched.count') do
      @log.applied_source=@source.id.to_s
    end
  end

  test "applied_source=nil should unmatch all the messages" do
    @log.applied_source=@source.id.to_s
    assert_difference ('@log.log_messages.unmatched.count') do
      @log.applied_source=""
    end
  end
end
