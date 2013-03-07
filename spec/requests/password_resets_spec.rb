require 'spec_helper'

describe "PasswordResets" do
  subject { page }
  it "emails user when requesting password reset" do
    user = Factory(:user)
    visit new_session_path
    click_link "Reset password"
    fill_in "Username", :with => user.username    
    click_button "Reset Password"   
    current_path.should eq(root_path)
    should have_content("Email sent with password reset instructions.")
    last_email.to.should include(user.email)
  end
  
  it "does not email invalid user when requestion password reset" do
    visit new_session_path
    click_link "Reset password"
    fill_in "Username", :with => "nobody"
    click_button "Reset Password"
    current_path.should eq(root_path)
    should have_content("Email sent with password reset instructions.")
    last_email.should be_nil
  end
  
  it "updates the user password when confirmation matches" do
    user = Factory(:user, :password_reset_token => "something", 
           :password_reset_sent_at => 1.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "Password", :with => "foobar"
    click_button "Update Password"
    should have_content("Password doesn't match confirmation") 
    fill_in "Password", :with => "foobar"
    fill_in "Retype Password", :with => "foobar"
    click_button "Update Password"
    current_path.should eq(root_path)
    should have_content("Password has been reset")
  end
  
  it "reports when password token has expired" do
    user = Factory(:user, :password_reset_token => "something", 
           :password_reset_sent_at => 3.hour.ago) 
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "Password", :with => "foobar"
    fill_in "Retype Password", :with => "foobar"
    click_button "Update Password"
    should have_content("Password reset has expired")
  end
  
  it "raised record not found when password token is invalid" do
    lambda {
      visit edit_password_reset_path("invalid")
    }.should raise_exception(ActiveRecord::RecordNotFound)
  end
end
