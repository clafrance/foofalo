class SessionsController < ApplicationController
  # force_ssl :only => [:new, :create]
    
  def new
    if current_user.nil?
      store_referrer_location
      @focus ="autofocus"
    else
      sign_out
      flash[:notice] = "Previous user has been signed out, you can signin now."
      redirect_to new_session_url
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
          flash[:success] = "You have successfully signed in!"
        else      
          redirect_to root_url, :notice => "still waiting for your parents approval."
        end
      else
        flash.now.alert = "Invalid username or password"
        render "new"
      end
    else
      sign_out
      flash[:success] = "Previous user: #{current_user} has been signed out, try signin again."
      redirect_to new_session_url
    end
  end
  
  def destroy
    sign_out
    flash[:success] = "See you next time!"
    redirect_to root_url
  end
  
  def guest
    user = User.find_by_username("guest")
    sign_in(user)
    redirect_to index_url
  end
end
