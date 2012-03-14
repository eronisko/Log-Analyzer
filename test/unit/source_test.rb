require 'test_helper'

class SourceTest < ActiveSupport::TestCase
  setup do
    @new_source = Source.new( name: "Apache Combined Access2",
                          description: "extracting error messages",
                          timestamp_definition: "(+.)",
                          field_1_name: "errno",
                          field_1_definition: "\w+"
                        )
  end
  test "has to have a name" do
    @new_source.name = nil
    assert !@new_source.save
  end

  test "names must be unique" do
    @new_source.name = sources(:apache_combined_errors).name
    assert !@new_source.save
  end

  test "must have a timestamp definition" do
    @new_source.timestamp_definition = nil
    assert !@new_source.save
  end

  test "apply_to_log should apply pattern names to matching messages" do
    log = logs(:web_server)
    source = sources(:apache_combined_errors)

    assert log.log_messages.matched.count == 0
    
    assert_difference ('log.log_messages.matched.count') do
      source.apply_to_log(log)
    end
  end
  
  #TODO
  #test "apply_to_log should reset all the extraction fields at start"

  test "find_custom_field_id_by_name should return a field String" do
    source = sources(:apache_combined_errors)
    result = source.find_custom_field_id_by_name("client_error")

    assert result.eql? "field_1"
  end

  test "get_custom_field_pattern should return a pattern String" do
    source = sources(:apache_combined_errors)
    field_id = source.find_custom_field_id_by_name("client_error")
    result = source.get_custom_field_pattern(field_id)

    assert result.eql? source.field_1_definition
  end

  #TODO
  #test "should validate message_patterns for non-existing entries"
end
