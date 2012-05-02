class UsersController < ApplicationController
  force_ssl :only => [:new, :create, :edit, :update]
  before_filter :signed_in_user, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user,   :only => [:edit, :update]
  before_filter :admin_user?,    :only => :destroy
  
  def index
    #@users = User.all
    @users = User.paginate(:page => params[:page], :per_page => 20)
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.firstname
  end 
  
  # def update_privilege
  #   @user = User.find(params[:id])
  # end
  
  def new
    if current_user.nil?
      @user = User.new
      @focus ="autofocus"
    else
      sign_out
      flash[:notice] = "Previous user has been signed out, you can signup now."
      redirect_to signup_url
    end
  end
  
  def create
    if current_user.nil?
      @user = User.new(params[:user])
      emails = ["christie.lafrance@gmail.com", "gclafrance@gmail.com", "philliptao@gmail.com"]
      emails.each do |email|
        if @user.email == email
          @user.privilege = "admin"
          break
        end
      end
  
      if @user.save 
        if @user.send_inform_parents
          redirect_to root_url, :notice => "#{@user.username} You have signed up. Your parents should receive 
            an email with a link to approval, then you can signin and have fun."
        else 
          redirect_to root_url, :notice => "You have signed up, but couldn't send confirmation to your parants, contact foofalo.com here."
        end
      else      
        render 'new'
      end
    else
      sign_out
      flash[:notice] = "Previous user has been signed out, try signup again."
      redirect_to root_url
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user = current_user
      if @user.update_attributes(params[:user])
        flash[:success] = "Profile Updated"
        redirect_to @user
      else
        render 'edit'
      end
    else
      flash[:notice] = "You can only update your own profile"
      redirect_to root_url
    end
  end
  
  def update_privilege
    
  end
  
  # 
  # def cancel 
  #   redirect_to home_url
  # end
  
  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "User #{user.firstname} has been deleted."
    redirect_to users_path
  end
  
  private
  
  # def correct_user
  #   @user = User.find(params[:id])
  #   redirect_to(root_path) unless @user == current_user
  # end
end
