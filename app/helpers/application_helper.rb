module ApplicationHelper
    def logged_in_user
        unless logged_in?
          store_location 
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
      end
    
      def store_location
        session[:forwarding_url] = request.original_url if request.get?
      end
      
    
      def set_user
        @user = User.find(params[:id])
      end 
    
      def correct_user 
        set_user
        redirect_to root_url unless @user == current_user
      end 
    
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
    
      def log_in_as(user)
        session[:user_id] = user.id
      end
    
      #The below two methods are there to enable 'friendly-forwarding'.  If a user is prompted to log in when trying to access a page that requires login, then after providing credentials, the user experience is improved if the user is redirected to the original site they were trying to access.  
      def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
      end
end
