require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user1 = users(:test_user_michael)
    @user2 = users(:test_user_angelo)
  end

  test "should be valid" do 
    assert @user1.valid?
  end 


  test "should get index" do
    log_in_as(@user1)
    if logged_in?
      get users_url
      assert_response :success
    else  
      assert_redirected_to root_path 
    end 
  end


  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: {  } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user1)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user1)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user1), params: { user: {  } }
    assert_redirected_to user_url(@user1)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user1)
    end

    assert_redirected_to users_url
  end
end
