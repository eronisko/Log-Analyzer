require 'test_helper'

class EliminationListTest < ActiveSupport::TestCase
  setup do
    @new_list = EliminationList.new(name: "Apache 200 messages",
                                    description: "a description",
                                    pattern_list: 'HTTP/1.1" 200'
                                   )
  end

  test "should have a name" do
    @new_list.name = nil
    assert !@new_list.save
  end

  test "should have a unique name" do
    same_name_list      = @new_list
    same_name_list.name = elimination_lists(:apache_200_300).name

    assert !same_name_list.save, "Successfully saved a duplicate name"
  end

  test "should have a non-empty pattern list" do
    @new_list.pattern_list = nil
    assert !@new_list.save
  end
end
