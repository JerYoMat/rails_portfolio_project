class UsersController < ApplicationController
    def new 
        @user = User.new 
    end 
  
    def create
        @user = User.new(user_params)
        if @user.save 
            redirect_to @user 
        else  
         render 'new'
        end 
    end 
  
    def show 
      set_user
    end 
  
    def edit
      if !logged_in?
        redirect_to login_path 
      else  
        set_user 
      end 
      redirect_to root_path unless @user == current_user
    end 
  
    def update 
        set_user
        if @user == current_user 
            redirect_to @user 
        else 
     redirect_to root_path
        end 

    
    end 
  
    def index 
      logged_in_user 
      @users = User.all  
    end 
  
    def destroy
        set_user 
        if current_user == @user 
            @user.destroy 
        end 
        redirect_to root_path
    end 

private
    def user_params
        params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :has_graduated)
      end
end
