require 'test_helper'

class LogMessageTest < ActiveSupport::TestCase
  test "ignore_matching should set uninteresting message to ignored" do
    @log = logs(:web_server)
    @ignore_list = ignore_lists(:apache_200_300)
    
    assert_difference ('@log.log_messages.ignored.count') do
      @log.log_messages.ignore_matching @ignore_list
    end
  end

  test "extract_data_by_pattern should extract data from a log message" do
    pattern = message_patterns(:client_error)
    msg = log_messages(:a_404_message)

    assert_nil msg.field_1
    msg.extract_data_by_pattern pattern.to_regexp, pattern
    updated_msg = LogMessage.find(msg)
    assert_equal "404", updated_msg.field_1
  end
end
