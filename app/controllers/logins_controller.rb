class LoginsController < ApplicationController
  
  def new
    
  end 
  
  def create
    # binding.pry
    chef = Chef.find_by(email: params[:email])
    if chef && chef.authenticate(params[:password])
      session[:chef_id] = chef.id
      flash[:success] = "You are login"
      redirect_to recipes_path
    else 
      flash.now[:danger] = "Your email address or password does not match"
      render 'new'
    end
  end
  
  def destroy
    session[:chef_id] = nil
    flash[:success] = "You are logout"
    redirect_to root_path
  end
  
end
