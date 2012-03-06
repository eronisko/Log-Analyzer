require 'test_helper'

class IgnoreListTest < ActiveSupport::TestCase
  setup do
    @new_list = IgnoreList.new(name: "Apache 200 messages",
                                    description: "a description",
                                    pattern_list: "my pattern"
                                   )
  end

  test "should have a name" do
    @new_list.name = nil
    assert !@new_list.save
  end

  test "should have a unique name" do
    same_name_list      = @new_list
    same_name_list.name = ignore_lists(:apache_200_300).name
    assert !same_name_list.save, "Successfully saved a duplicate name"
  end

  test "should have a non-empty pattern list" do
    @new_list.pattern_list = nil
    assert !@new_list.save
  end

  test "filter_log should set uninteresting message to ignored" do
    @log = logs(:web_server)
    @pattern_list = ignore_lists(:apache_200_300)
    
    assert_difference ('@log.log_messages.ignored.count') do
      @pattern_list.filter_log(@log)
    end
  end
end
