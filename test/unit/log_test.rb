require 'test_helper'

class LogTest < ActiveSupport::TestCase
  fixtures :logs, :investigations

  setup do
    @new_log = Log.new(investigation_id: 1,
                       name: 'Database Log',
                       description: 'MySQL database server',
                       data_type: 'plaintext',
                       path: '/tmp/db_log',
                       time_bias: 0
                      )
  end

  test "log names have to be unique within an investigation" do
    same_log      = @new_log
    same_log.name = logs(:web_server).name
    
    assert !same_log.save, 'Successfully saved a duplicate log'
  end

  test "log names can repeat across different investigations" do
    different_log                   = @new_log 
    different_log.name              = logs(:web_server).name
    different_log.investigation_id  = 2

    assert different_log.save
  end
  
  test "has to have a name" do
    @new_log.name = nil
    assert !@new_log.save
  end
  
  test "has to have a data type" do
    @new_log.data_type = nil
    assert !@new_log.save
  end
  
  test "has to have a path" do
    @new_log.path = nil
    assert !@new_log.save
  end
  
  test "has to have a valid time bias" do
    @new_log.time_bias = nil
    assert !@new_log.save

    @new_log.time_bias = 'hello'
    assert !@new_log.save
  end
    
end
