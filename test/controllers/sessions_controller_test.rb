require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do 
    get login_path 
    assert_response :success
  end 

  test 'after logging out user goes to root' do 
    log_in_as(users(:test_user_michael))
    delete logout_path 
    assert_redirected_to root_path, 'users that log out should be redirected to home'
  end 
end
