require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:bikes)
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)

  test "it can own a bike" do
    user = create_user
    user.bikes << create_bike
    user.bikes << create_bike
    assert_equal 2, user.bikes.count
  end
end
