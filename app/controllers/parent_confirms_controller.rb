class ParentConfirmsController < ApplicationController
  
  def edit
    @user = User.find_by_inform_parents_token!(params[:id])
    @user.parent_approved = "Yes"
    @user.parent_approved_at = Time.zone.now
      if @user.save && @user.parent_approved == "Yes"
      # UserMailer.registration_confirmation(user).deliver
        flash[:success] = "Parent approved for #{@user.firstname}"
        redirect_to root_url
      else
        flash[:noticd] = "There is a problem approving #{@user.firstname}"
        redirect_to root_url
      end
  end
  
  #try 
  # def update
  #   @user = User.find_by_inform_parents_token!(params[:id])
  #   if @user.update_attributes(params[:user])
  #   # UserMailer.registration_confirmation(user).deliver
  #     flash[:success] = "Parent approved for #{@user.firstname}"
  #     redirect_to root_url
  #   else
  #     flash[:noticd] = "There is a problem approving #{@user.firstname}"
  #     redirect_to root_url
  #   end 
  # end
end
