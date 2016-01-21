require 'test_helper'

class UserCanCrudBikesTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.app = Sodata::Application
    stub_ominiauth
  end

  def add_bike
    click_on "Add A New Bike"
    fill_in "model", with: "Test Model"
    fill_in "make", with: "Test Make"
    fill_in "description", with: "Test Description"
    fill_in "serial_number", with: "Test Serial Number"
    select "Road", :from => "terrain"
    click_on "Complete Registration"
  end

  test "can add a bike" do
    visit "/"
    click_link "Login"
    click_on "Add A New Bike"
    fill_in "model", with: "Test Model"
    fill_in "make", with: "Test Make"
    fill_in "description", with: "Test Description"
    fill_in "serial_number", with: "Test Serial Number"
    select "Road", :from => "terrain"
    click_on "Complete Registration"

    assert_equal dashboard_path, current_path
    assert page.has_content?("Test Model")
    assert page.has_content?("Test Make")
    assert page.has_content?("Test Description")
    assert page.has_content?("Test Serial Number")
  end

  test "can remove a bike" do
    visit "/"
    click_link "Login"
    add_bike

    within ".ui.list.bikes" do
      first('#delete').click_link('Delete?')
    end

    refute page.has_content?("Test Model")
    refute page.has_content?("Test Make")
    assert_equal dashboard_path, current_path
  end

  test "can go missing" do
    visit "/"
    click_link "Login"
    add_bike
    assert_equal dashboard_path, current_path

    twilio = TwilioService.new
    message = "Please be on the look out for this missing bike."
    twilio.stubs(:build_sms).returns(message)
    NotificationsMailer.any_instance.stubs(:send_stolen_alert).returns("Good Job")
  
    within ".ui.list.bikes" do
      first('#missing').click_link('Missing?')
    end

    assert_equal twilio.build_sms, message
    assert_equal dashboard_path, current_path
  end
end

