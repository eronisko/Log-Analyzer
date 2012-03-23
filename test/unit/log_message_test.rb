require 'test_helper'

class LogMessageTest < ActiveSupport::TestCase
  test "ignore_matching should set uninteresting message to ignored" do
    @log = logs(:web_server)
    @ignore_list = ignore_lists(:apache_200_300)
    
    assert_difference ('@log.log_messages.ignored.count') do
      @log.log_messages.ignore_matching @ignore_list
    end
  end

  test "matching_regex scope should return messages matching a regex" do
    log = logs(:web_server)
    regex_string = message_patterns(:client_error).to_s

    expected_cnt = log.log_messages.where('raw_message REGEXP ?',
                                        regex_string).count

    assert_equal log.log_messages.matching_regex(regex_string).count,
                 expected_cnt
  end

  #test "apply_source should reset all the extraction fields at start"
  test "apply_source should apply message_patterns to matching messages" do
    log = logs(:web_server)
    source = sources(:apache_combined_errors)

    assert log.log_messages.matched.count == 0
    
    assert_difference ('log.log_messages.matched.count') do
      log.log_messages.apply_source source
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
