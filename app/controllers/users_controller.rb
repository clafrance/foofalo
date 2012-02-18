class UsersController < ApplicationController
  before_filter :signed_in_user, :only => [:edit, :update]
  before_filter :correct_user,   :only => [:edit, :update]
  
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
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
    def signed_in_user
      redirect_to signin_path, notice: "Please sign in." if current_user.nil?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless @user == current_user
    end
end
