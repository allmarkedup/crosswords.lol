require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should show about page" do
    get about_page_url

    assert_response :success
    assert_dom ".page-title", "What's this?"
  end

  test "should show settings page" do
    get settings_page_url

    assert_response :success
    assert_dom ".page-title", "Settings"
  end
end
