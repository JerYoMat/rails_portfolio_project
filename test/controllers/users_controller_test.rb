require 'test_helper'
#General principals 
#Unknown users get sent to login if attempting to access page with restricted access
#Known users attempting to perform unauthorized actions get sent to root 

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user1 = users(:test_user_michael)
    @user2 = users(:test_user_angelo)
    @new_user = User.new(name: "tname",
                         email: "temail@emails.com", 
                         password: "password", 
                         password_confirmation: "password",
                         has_graduated: false)
  end

  test 'should be valid' do 
    assert @user1.valid? && @user2.valid? && @new_user.valid?
  end 

  test "should get index for logged in users" do
    log_in_as(@user1)
    get users_url
    assert_response :success
  end

  test 'must log in for index' do 
    get users_url 
    assert_redirected_to login_url
  end 


  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { name: @new_user.name,
                                        email: @new_user.email,
                                        password: "password",
                                        password_confirmation: 'password',
                                        has_graduated: @new_user.has_graduated  } }
    end
    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user1)
    assert_response :success
  end

  test "authorized user can edit" do
    log_in_as(@user1)
    get edit_user_url(@user1)
    assert_response :success
  end

  test 'different user cannot edit' do 
    log_in_as(@user2)
    get edit_user_url(@user1)
    assert_redirected_to root_path
  end 

  test 'unknown user cannot edit' do 
    get edit_user_url(@user1)
    assert_redirected_to login_path
  end 

  test "authorized user can update" do
    log_in_as(@user1)
    patch user_url(@user1), params: { user: { name: @user1.name,
                                              email: @user1.email,
                                              password: 'password',
                                              password_confirmation: 'password' } }
    assert_redirected_to user_url(@user1)
  end


  test "authorized user can update without providing password" do
    log_in_as(@user1)
    patch user_url(@user1), params: { user: { name: "NEW NAME!",
                                              email: @user1.email } }
    assert @user1.name = "NEW NAME!"
  end


  test 'different user cannot update' do 
    log_in_as(@user2)
    patch user_url(@user1), params: { user: { name: @user1.name,
    email: @user1.email,
    password: 'password',
    password_confirmation: 'password' } }
    assert_redirected_to root_path
  end 

  test "authorized user can destroy" do
    log_in_as(@user1)
    assert_difference('User.count', -1) do
      delete user_url(@user1)
    end
    assert_redirected_to root_path
  end
  
  test "different user cannot destroy" do
    log_in_as(@user2)
    assert_no_difference('User.count', -1) do
      delete user_url(@user1)
    end
    assert_redirected_to root_path
  end

  test "unknown user cannot destroy" do
    assert_no_difference('User.count', -1) do
      delete user_url(@user1)
    end
    assert_redirected_to root_path
  end
end
