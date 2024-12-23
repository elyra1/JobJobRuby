require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get pages_home_url
    assert_response :success
  end

  test "should get worker" do
    get pages_worker_url
    assert_response :success
  end

  test "should get employer" do
    get pages_employer_url
    assert_response :success
  end
end
