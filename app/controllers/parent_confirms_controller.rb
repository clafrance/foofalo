class ParentConfirmsController < ApplicationController
  
  def edit
    @user = User.find_by_inform_parents_token!(params[:id])
  end
  
  def update
    @user = User.find_by_inform_parents_token!(params[:id])
    @user.update_attributes(params[:user])
    # UserMailer.registration_confirmation(user).deliver
    flash[:success] = "Parent approved for #{@user.firstname}"
    redirect_to root_url
  end
end
