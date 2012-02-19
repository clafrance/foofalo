class UsersController < ApplicationController
  before_filter :signed_in_user, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user,   :only => [:edit, :update]
  before_filter :admin_user?,     :only => :destroy
  
  def index
    #@users = User.all
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.firstname
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
  
  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "User #{user.firstname} has been deleted."
    redirect_to users_path
  end
  
  private
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) if @user != current_user
    end
  
    def signed_in_user
      if current_user.nil?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end
    
    def admin_user?
      redirect_to(root_path) if current_user.privilege != 0
    end
end
