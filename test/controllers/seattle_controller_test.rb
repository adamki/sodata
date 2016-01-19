require 'test_helper'

class SeattleControllerTest < ActionController::TestCase
  test "#bike Thefts" do
    skip
    get :bike_thefts

    socrata_service = SocrataService.new
    response = {bike_thefts: true}
    socrata_service.stubs(:bike_thefts).returns(response)
    assert_response :success
  end
end
