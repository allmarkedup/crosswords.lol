require "test_helper"

class CrosswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @crossword = Crossword.random
  end

  test "root URL should redirect to latest crossword" do
    get root_url
    assert_redirected_to crossword_url(Crossword.latest)
  end

  test "should show crossword" do
    get crossword_url(@crossword)
    assert_response :success
  end
end
