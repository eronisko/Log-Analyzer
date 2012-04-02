require 'test_helper'

class LogMessageTest < ActiveSupport::TestCase
  setup do
    @pattern = message_patterns(:client_error)
    @msg = log_messages(:a_404_message)
    @log = logs(:web_server)
    @ignore_list = ignore_lists(:apache_200_300)
  end

  test "ignore_matching should set uninteresting message to ignored" do
    assert_difference ('@log.log_messages.ignored.count') do
      @log.log_messages.ignore_matching @ignore_list
    end
  end

  test "extract_data_by_pattern should extract data from a log message" do
    assert_nil @msg.field_1
    @msg.extract_data_by_pattern @pattern.to_regexp, @pattern
    updated_msg = LogMessage.find(@msg)
    assert_equal "404", updated_msg.field_1
  end

  test "unmatch! should clear all the extracted data" do
    @msg.extract_data_by_pattern @pattern.to_regexp, @pattern
    @msg.log.log_messages.unmatch!
    updated_msg = LogMessage.find(@msg)
    assert_nil updated_msg.timestamp
  end

  test "unignore! should set messages to active" do
    @log.log_messages.ignore_matching @ignore_list
    assert_difference ('@log.log_messages.active.count') do
      @log.log_messages.unignore!
    end
  end

  test "extract_data should extract time and apply time bias" do
    assert_nil @msg.timestamp
    @msg.extract_data_by_pattern @pattern.to_regexp, @pattern
    updated_msg = LogMessage.find(@msg)

    time_from_str = DateTime.strptime("10/Jan/2012:22:49:41", 
                    @pattern.source.timestamp_definition)

    desired_time = time_from_str + @msg.log.time_bias.seconds

    assert_equal desired_time, updated_msg.timestamp
  end

end
