require 'test_helper'

class EliminationListTest < ActiveSupport::TestCase
  setup do
    @new_list = EliminationList.new(name: "Apache 200 messages",
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
    same_name_list.name = elimination_lists(:apache_200_300).name
    assert !same_name_list.save, "Successfully saved a duplicate name"
  end

  test "should have a non-empty pattern list" do
    @new_list.pattern_list = nil
    assert !@new_list.save
  end

  test "apply_to_log should set messages to ignored" do
  #  @log = logs(:web_server)
  #  @pattern_list = elimination_lists(:apache_200_300)

  #  @pattern_list.apply_to_log
  end

  test "filter_log_message should set blacklisted messages to ignored" do
    @uninteresting_message = log_messages(:a_200_message)
    @pattern_list = elimination_lists(:apache_200_300)

    assert !@uninteresting_message.ignored?
    @pattern_list.filter_log_message(@uninteresting_message)
    puts @uninteresting_message.inspect
    puts @uninteresting_message.raw_message
    assert @uninteresting_message.ignored?, "Uninteresting message not ignored"
  end
end
