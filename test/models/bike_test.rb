require 'test_helper'

class BikeTest < ActiveSupport::TestCase
  should belong_to(:user)
  should validate_presence_of(:make)
  should validate_presence_of(:model)
  should validate_presence_of(:description)
  should validate_presence_of(:serial_number)
  should validate_presence_of(:terrain)

  test "it belongs to a user" do
    bike = create_bike
    user = create_user
    bike.user_id = user.id
    assert_equal bike.user, user
    assert bike.valid?
  end
end
