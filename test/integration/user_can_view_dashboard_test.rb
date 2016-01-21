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
    visit "/"
    click_link "Login"
    click_on "View Maps"
    
    assert_equal seattle_crime_path, current_path

    assert page.has_css?("input#pac-input")
    assert page.has_css?("input#500")
    assert page.has_css?("input#1250")
  end
end

