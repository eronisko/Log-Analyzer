require 'test_helper'

class InvestigationTest < ActiveSupport::TestCase
  fixtures :investigations
  test "investigation is not valid without a unique name" do
    investigation = 
      Investigation.new(name: investigations(:flower_shop).name)

    assert !investigation.save
    assert_equal "has already been taken", investigation.errors[:name].join('; ')
  end
end
