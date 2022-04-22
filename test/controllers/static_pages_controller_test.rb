require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get shipment" do
    get static_pages_shipment_url
    assert_response :success
  end

end
