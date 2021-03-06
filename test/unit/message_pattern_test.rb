require 'test_helper'

class MessagePatternTest < ActiveSupport::TestCase
  setup do
    @new_pattern = MessagePattern.new(
                        message_patterns(:client_error).attributes
                   )
    @new_pattern.name = "A unique pattern name"

    @new_source = Source.new(sources(:apache_combined_errors).attributes)
    @new_source.name  = "A unique source name"
  end

  test "must have a source" do
    @new_pattern.source = nil
    assert !@new_pattern.save, 'Successfully saved a pattern without source'
  end

  test "names have to be unique within a source" do
    @new_pattern.name = message_patterns(:client_error).name
    assert !@new_pattern.save, 'Successfully saved a duplicate pattern'
  end

  test "names can repeat across different sources" do
    @new_pattern.name    = message_patterns(:client_error).name
    @new_pattern.source  = @new_source 

    assert @new_pattern.save
  end

  test "has to have a name" do
    @new_pattern.name = nil
    assert !@new_pattern.save
  end

  test "has to have a pattern" do
    @new_pattern.pattern = nil
    assert !@new_pattern.save
  end

  test "to_regexp should return a Regexp" do
    regex_pattern = message_patterns(:client_error).to_regexp
    assert_instance_of Regexp, regex_pattern

    # testing replace_keywords
    desired_string = '.+ \[(?<timestamp>.+?)\] \".+?\" (?<field_1>4\w+)'

    assert_equal Regexp.new(desired_string), regex_pattern
  end

  test "to_s should return an interpolated String" do
    regex_string = message_patterns(:client_error).to_s
    assert_instance_of String, regex_string

    # testing replace_keywords
    desired_string = '.+ \[(?<timestamp>.+?)\] \".+?\" (?<field_1>4\w+)'

    assert_equal desired_string, regex_string
  end
end
