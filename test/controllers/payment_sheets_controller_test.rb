require 'test_helper'

class PaymentSheetsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get payment_sheets_create_url
    assert_response :success
  end

end
