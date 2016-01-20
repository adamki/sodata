require 'test_helper'

class UserCanViewdashboardTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.app = Sodata::Application
    stub_ominiauth
  end

  def add_bike
    click_on "Add New Bike"
    fill_in "model", with: "Test Model"
    fill_in "make", with: "Test Make"
    fill_in "description", with: "Test Description"
    fill_in "serial_number", with: "Test Serial Number"
    select "Road", :from => "terrain"
    click_on "Everything Look OK?"
  end

  test "dashboard#show" do
    VCR.use_cassette("dashboard#show") do
      visit "/"
      click_link "Login"
      click_on "View Maps"
      
      twilio = TwilioService.new
      message = "Please be on the look out for this missing bike."
      twilio.stubs(:build_sms).returns(message)

      socrata_service = SocrataService.new
      response = {bike_thefts: true}
      socrata_service.stubs(:bike_thefts).returns(response)
      socrata_service.stubs(:parse).returns(response)
      socrata_service.stubs(:get_racks).returns(response)

      assert_equal seattle_crime_path, current_path
      assert_equal response, socrata_service.bike_thefts
    end
  end
end

