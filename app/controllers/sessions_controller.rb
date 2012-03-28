class SessionsController < ApplicationController
  force_ssl :only => [:new, :create]
    
  def new
    store_referrer_location
    @focus ="autofocus"
  end
  
  def create
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
  end
  
  def destroy
    sign_out
    redirect_to root_url, :notice => "See you next time!"
  end
end
