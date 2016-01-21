require 'test_helper'

class SeattleControllerTest < ActionController::TestCase
  test "#bike_thefts" do
    VCR.use_cassette("seattle#bike_thefts") do
      get :bike_thefts, format: :json, lat: '47.612926', lng: '-122.336815', radius: 250
      assert_response :success

      assert_equal 3, json_response.count
      assert_equal 30, json_response["crimes"].count
      assert_equal 28, json_response["racks"].count
      times = {"9PM"=>2, "3PM"=>5, "4PM"=>1, "10AM"=>3, "11AM"=>4, "7PM"=>3, 
               "7AM"=>2, "2PM"=>2, "8PM"=>2, "5PM"=>1, "12PM"=>4, "1PM"=>1}
      assert_equal times, json_response["times"]
    end
  end
end
