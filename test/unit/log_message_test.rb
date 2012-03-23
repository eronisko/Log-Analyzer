require 'test_helper'

class LogMessageTest < ActiveSupport::TestCase
  test "ignore_matching should set uninteresting message to ignored" do
    @log = logs(:web_server)
    @pattern_list = ignore_lists(:apache_200_300)
    
    assert_difference ('@log.log_messages.ignored.count') do
      @log.log_messages.ignore_matching @pattern_list
    end
  end
end
