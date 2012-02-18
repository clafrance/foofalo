class SessionsController < ApplicationController
  
  def new
    store_referrer_location
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:remember_token] = user.remember_token
      else
        cookies[:remember_token] = user.remember_token
      end
      redirect_back_or user
      #redirect_to user, :notice => "#{current_user.firstname} is signed in to Foofalo!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
  
  def destroy
    cookies.delete(:remember_token)
    redirect_to root_url, :notice => "See you next time!"
  end
end
