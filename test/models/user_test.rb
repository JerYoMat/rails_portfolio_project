require 'test_helper'


class UserTest < ActiveSupport::TestCase
  def setup
    @user1 = users(:test_user_michael)
    @user2=User.new( name: 'tango',
                     email: 'tango@testusermodel.com', password: 'password', password_confirmation: 'password', has_graduated: false) 
  end 

  test 'should be valid'  do
    assert @user1.valid?  
  end 

  test 'user name  is required' do
    @user2.name = '   ' 
    assert_not @user2.save 
  end 

  test 'name does not exceed length limit' do 
    @user1.name = 'a' * 260 
    assert_not @user1.save
  end

  test 'unique email address is required' do 
    @user1.save 
    @user2.email = @user1.email.upcase
    assert_not @user2.save, 'User2 should not save with email equal to existing user'
  end 

  test 'email address does not exceed length limit' do 
    @user1.email = 'a' * 250 + '@name.com'
    assert_not @user1.save
  end 


  test 'valid email address format is accepted' do 
    valid_email_addresses = %w[test1@use.com TEST@EXAMPLE.CoM with.period@999.com FOREIGN@Gruen.de]
    valid_email_addresses.each do |single_address|
      assert @user1.valid?, "#{single_address.inspect} should be valid"  
    end 
  end 

  test 'invalid email address is rejected' do 
    invalid_email_addresses = %w[test.com @gmail.com firstname_last testuser@gmail]
    invalid_email_addresses.each do |single_address|
      @user1.email = single_address
      assert_not @user1.valid?, "#{single_address.inspect} should not be considered a valid email"
    end 
  end 

  test 'password matches password_confirmation' do 
    @user2.password_confirmation = ''
    assert_not @user2.valid?, 'password and password confirmation should match'
  end

  test "password requires minimum length" do 
    @user1.password = @user1.password_confirmation = "123"
    assert_not @user1.valid?
    @user1.password = @user1.password_confirmation = "1234567"
    assert @user1.valid?
  end 

  test 'has_graduated is required' do 
    @user3=User.new( name: 'michael',
      email: 'michaessssl@testusermodel.com', password: 'password', password_confirmation: 'password') 
    assert_not @user3.valid?
  end 

end
