require 'test_helper'

class OfficeTest < ActiveSupport::TestCase
  def setup
    @office = Office.new(name: "Example Office", email: "office@example.com")
  end

  test "should be valid" do
    assert @office.valid?
  end
  
  test "name should be present" do
    @office.name = "     "
    assert_not @office.valid?
  end
  
  test "email should be present" do
    @office.email = "     "
    assert_not @office.valid?
  end
  
  test "name should not be too long" do
    @office.name = "a" * 51
    assert_not @office.valid?
  end

  test "email should not be too long" do
    @office.email = "a" * 244 + "@example.com"
    assert_not @office.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @office.email = valid_address
      assert @office.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @office.email = invalid_address
      assert_not @office.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @office.dup
    duplicate_user.email = @office.email.upcase
    @office.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @office.email = mixed_case_email
    @office.save
    assert_equal mixed_case_email.downcase, @office.reload.email
  end
end
