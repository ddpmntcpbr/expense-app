require 'test_helper'

class OfficesSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Office.count' do
      post offices_path, params: { office: { name:  "",
                                         email: "office@invalid"}}
    end
    assert_template 'offices/new'
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'Office.count', 1 do
      post offices_path, params: { office: { name:  "Test Company",
                                         email: "test@example.com"} }
    end
    follow_redirect!
    assert_template 'offices/show'
  end
end
