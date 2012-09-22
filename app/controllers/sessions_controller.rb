class SessionsController < ApplicationController
  # force_ssl :only => [:new, :create]
    
  def new
    if current_user.nil?
      store_referrer_location
      @focus ="autofocus"
    else
      sign_out
      flash[:notice] = "Previous user has been signed out, you can signin now."
      redirect_to signin_url
    end
  end
  
  def create
    if current_user.nil?
      user = User.find_by_username(params[:username])
      if user && user.authenticate(params[:password])
        if user.parent_approved =="Yes" && user.parent_approved_at
          if params[:remember_me]
            sign_in_remember(user)
          else
            sign_in(user)
          end
          redirect_back_or(index_url)
        else      
          redirect_to root_url, :notice => "still waiting for your parents approval."
        end
      else
        flash.now.alert = "Invalid username or password"
        render "new"
      end
    elsif current_user == "guest"
      sign_in(user)
    else
      sign_out
      flash[:notice] = "Previous user: #{current_user} has been signed out, try signin again."
      redirect_to signin_url
    end
  end
  
  def destroy
    sign_out
    redirect_to root_url, :notice => "See you next time!"
  end
  
  def guest
    user = User.find_by_username("guest")
    sign_in(user)
  end
end
