ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  def log_in(user)
    session[:user_id] = user.id
  end 
  
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])  # Same as @current_user = @current_user || User.find_by(id: session[:user_id])
    end 
  end

  def logged_in?
     !current_user.nil?
  end 
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest

  # Log in as a particular user.
  def log_in_as(user, password: 'password')
    post login_path, params: { session: { email: user.email,
                                          password: password } }
  end
end