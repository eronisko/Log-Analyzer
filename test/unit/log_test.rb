require 'test_helper'

class LogTest < ActiveSupport::TestCase
  setup do
    @new_log = Log.new(investigation: investigations(:flower_shop),
                       name: 'Database Log',
                       description: 'MySQL database server',
                       data_type: 'plaintext',
                       file: 'test/fixtures/flower_shop_log.log',
                       time_bias: 0
                      )
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
    
end
