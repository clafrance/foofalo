class SessionsController < ApplicationController
  
  def new
    store_referrer_location
  end
  
  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      if user.parents_approve == "true"
        if params[:remember_me]
          cookies.permanent[:remember_token] = user.remember_token
        else
          cookies[:remember_token] = user.remember_token
        end
        redirect_back_or root_url
      elsif user.parents_approve == "false"
        redirect_to root_url, :notice => "Sorry your parents didn't approve you to have this account."
      else      
        redirect_to root_url, :notice => "still waiting for your parents approval."
      end
    else
      flash.now.alert = "Invalid username or password"
      render "new"
    end
  end
  
  def destroy
    cookies.delete(:remember_token)
    redirect_to root_url, :notice => "See you next time!"
  end
end
