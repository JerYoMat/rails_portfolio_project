class LearnTipsController < ApplicationController
  def new 
    if logged_in?
    @learn_tip = LearnTip.new 
    else  
      redirect_to login_path
    end 
  end 

  def create 
    if logged_in? 
      if @current_user.id == params[:learn_tip][:user_id].to_i
        @learn_tip = current_user.learn_tips.build(tip_params)
        if @learn_tip.save
          @learn_tip.save
          redirect_to lesson_learn_tips_url @learn_tip.lesson
        else 
         render 'new'
        end
      else
        redirect_to root_path 
      end  
    else 
      redirect_to login_path
    end  

  end 

  def show 
    @learn_tip = LearnTip.find(params[:id])
  end 

  def edit 
    if logged_in?
      @learn_tip = LearnTip.find(params[:id])

      if @learn_tip.user != current_user
         redirect_to root_path
      end 
    else  
      redirect_to login_path
    end 
  end 

  def update 
    @learn_tip = LearnTip.find(params[:id])

  if logged_in?
    if @learn_tip.user == current_user
      @learn_tip.update_attributes(tip_params)
      redirect_to @learn_tip
    else   
      redirect_to root_path 
    end 
  else 
   redirect_to root_path 
  end     
  end 

  def index 
    @index = LearnTip.all 
  end 

  def destroy 

    @learn_tip = LearnTip.find(params[:id])
    if current_user == @learn_tip.user 
      @learn_tip.destroy 
    end 
    redirect_to root_path
  end 

  private 

  def tip_params
    params.require(:learn_tip).permit(:name, :description, :link, :lesson_id, :user_id)
  end 
end
