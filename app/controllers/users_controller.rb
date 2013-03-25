class UsersController < ApplicationController
  # force_ssl :only => [:new, :create, :edit, :update]
  before_filter :signed_in_user, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user,   :only => [:edit, :update]
  before_filter :admin_user?,    :only => [:destroy, :update_privilege]
  
  def index
    @users = User.all
    #@users = User.paginate(:page => params[:page], :per_page => 20)
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.firstname
  end 
  
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
      grant_user_privilege(@user)
      if @user.save
        if @user.send_inform_parents
          redirect_to root_url, :notice => "Welcome #{@user.username}, you have signed up. Your parents should receive 
            an email with a link to approve you using Foofalo. Once approved, you can signin and have fun."
        else 
          redirect_to root_url, :notice => "You have signed up, but couldn't send confirmation to your parants, please contact foofalo.com to resolve the issue."
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
      if @user.username != "guest"
        update_profile(@user)
      else
        flash[:notice] = "Guest user can't update user profile"
      end
    else
      flash[:notice] = "You can only update your own profile"
      redirect_to root_url
    end
  end
  
  def update_privilege
    user_id = params[:user_id]
    @user = User.find_by_id(user_id)
    if @user.update_attributes(params[:user])
      flash[:success] = "User privilege has been updated"
      redirect_to users_path
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
  
    def is_admin?(email)
      emails = ["christie.lafrance@gmail.com", "gclafrance@gmail.com", "philliptao@gmail.com"]
      emails.include?(email)
    end
    
    def is_super_user?(email)
      emails = ["arthur.lafrance@icloud.com", "matthew.lafrance@icloud.com"]
      emails.include?(email)
    end
  
    def grant_user_privilege(user)
      if is_admin?(user.email)
        user.privilege = "admin"
      elsif is_super_user?(user.email)
        user.privilege = "super_user"
      else
        user.privilege = "user"
      end
    end
    
    def update_profile(user)
      if user.update_attributes(params[:user])
        flash[:success] = "Profile Updated"
        redirect_to user
      else
        render 'edit'
      end
    end
end
