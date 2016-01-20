require 'test_helper'

class SeattleControllerTest < ActionController::TestCase
  test "#bike_thefts" do
    skip
    response = {bike_thefts: true}
    SocrataService.any_instance.stubs(:bike_thefts).returns(response)
    get :bike_thefts

    save_and_open_page
    assert_response :success
  end
end
