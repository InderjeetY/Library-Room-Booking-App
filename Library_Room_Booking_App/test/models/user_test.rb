require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email_id = "     "
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@library.com USER@you.COM A_AB-HI@nc.lib.org
                         start.end@foo.in abhi+singh@lib.cn]
    valid_addresses.each do |valid_address|
      @user.email_id = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@library,com user_at_ncsu.org no.domain@example.
                           abhi@nc_su.com you@nc+nc.com]
    invalid_addresses.each do |invalid_address|
      @user.email_id = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email_id.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  def setup
    @user = User.new(name: "Example User", email_id: "user@example.com",
                     password: "useruser")
  end
  test "password should be present (nonblank)" do
    @user.password = " "
    assert_not @user.valid?
  end
end
