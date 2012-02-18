class UsersController < ApplicationController
  
  def show
  end 
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      cookies[:remember_token] = @user.remember_token # signin user
      #flash[:success] = "Welcome to join Foofalo! #{current_user.firstname}"
      #redirect_to current_user
      redirect_to root_url, :notice => "Signed up"
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
end
