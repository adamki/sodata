require 'test_helper'

class SocrataServiceTest < ActiveSupport::TestCase

  test "#build_crimes" do
    VCR.use_cassette("ss#build_crimes_yea") do
      params = { lat: 47.612926,
                 lng: -122.336815,
                 dist: 500,
                 limit: 8000} # set unually high radius to capture richer dataset

      crimes = SocrataService.new.build_crimes(params[:lat], params[:lng], params[:dist], params[:limit])

      assert crimes
      assert_equal 3, crimes.keys.count
      assert_equal [:crimes, :times, :racks], crimes.keys
      times = {"9PM"=>178, "11AM"=>216, "4PM"=>263, "10AM"=>213, "6PM"=>213, 
               "1PM"=>260, "9AM"=>169, "7PM"=>191, "3PM"=>284, "8AM"=>118, 
               "12PM"=>305, "8PM"=>220, "7AM"=>70, "2PM"=>246, "10PM"=>126, 
               "5PM"=>282, "1AM"=>65, "11PM"=>106, "5AM"=>27, "3AM"=>26, 
               "6AM"=>27, "4AM"=>20, "2AM"=>19}

      assert_equal times, crimes[:times]

      general_location = "1ST AVE 0140 BLOCK SW SIDE ( 213) 182 FT SE/O PIKE ST"
      assert_equal general_location, crimes[:racks].first[:unitdesc]

    end
  end

end
