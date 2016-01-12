require 'test_helper'

class Api::V1::CrimesControllerTest < ActionController::TestCase

  test "#index" do
    crime_count = Crime.count
    get :index, format: :json

    assert_equal crime_count, json_response.count
    assert_response :success
  end
end
