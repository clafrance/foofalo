class UsernameReminderController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    @user = user
    if user
      user.send_username_reminder
      redirect_to root_url, :notice => "Email sent with username(s)."
    else
      redirect_to signin_url, :notice => "Invalid email address, please try again or contact us."
    end
  end
end
