require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", 'https://twitter.com/ddpmntcpbr'
    assert_select "a[href=?]", 'https://github.com/ddpmntcpbr/expense-app'
    assert_select "a[href=?]", 'https://qiita.com/ddpmntcpbr'
    
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
    get invite_path
    assert_select "title", full_title("Invite")
  end
end
