require 'test_helper'

class SourceTest < ActiveSupport::TestCase
  setup do
    @source = Source.new( name: "Apache Combined Access2",
                          description: "extracting error messages",
                          timestamp_definition: "(+.)",
                          field_1_name: "errno",
                          field_1_definition: "\w+"
                        )
  end
  test "has to have a name" do
    @source.name = nil
    assert !@source.save
  end

  test "names must be unique" do
    @source.name = sources(:apache_combined_errors).name
    assert !@source.save
  end

  test "must have a timestamp definition" do
    @source.timestamp_definition = nil
    assert !@source.save
  end
end
