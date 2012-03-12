require 'spec_helper'

describe "EditProfile" do
  
  it "updates user profile with valid info" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    visit signin_path
    fill_in "Username", :with => user.username
    fill_in "Password", :with => user.password
    click_button "Sign in"
    page.should have_content("Signed in as")
    page.should have_link("Users")
    page.should have_link("Sign out")
    click_link("Profile")

    fill_in "Password", :with => "ssssss"
    fill_in "Retype Password", :with => "ssssss"
    fill_in "First Name", :with => "new_first"
    fill_in "Last Name", :with => "new_last"
    fill_in "Parents' Email", :with => "lafrance.family@yahoo.com"
    fill_in "Retype Parents' Email", :with => "lafrance.family@yahoo.com"
    click_button "Update"
    current_path.should eq(user_path(user))
    page.should have_content("Profile Updated")
  end
  
  it "doesn't update user profile with invalid password" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    visit signin_path
    fill_in "Username", :with => user.username
    fill_in "Password", :with => user.password
    click_button "Sign in"
    page.should have_content("Signed in as")
    page.should have_link("Users")
    page.should have_link("Sign out")
    click_link("Profile")
    fill_in "Password", :with => "ssss"
    fill_in "Retype Password", :with => "ssss"
    click_button "Update"
    current_path.should eq(user_path(user))
    page.should have_content("Password is too short")
  end
  
  it "doesn't update user profile when password doesn't match confirmation" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    visit signin_path
    fill_in "Username", :with => user.username
    fill_in "Password", :with => user.password
    click_button "Sign in"
    page.should have_content("Signed in as")
    page.should have_link("Users")
    page.should have_link("Sign out")
    click_link("Profile")
    fill_in "Password", :with => "ssssss"
    fill_in "Retype Password", :with => "sssssss"
    click_button "Update"
    current_path.should eq(user_path(user))
    page.should have_content("Password doesn't match confirmation")
  end
  
  it "doesn't update user profile with invalid firstname" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    visit signin_path
    fill_in "Username", :with => user.username
    fill_in "Password", :with => user.password
    click_button "Sign in"
    page.should have_content("Signed in as")
    page.should have_link("Users")
    page.should have_link("Sign out")
    click_link("Profile")
    fill_in "First Name", :with => "new_first%^"
    click_button "Update"
    current_path.should eq(user_path(user))
    page.should have_content("Firstname is invalid")
  end
  
  it "doesn't update user profile with invalid lastname" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    visit signin_path
    fill_in "Username", :with => user.username
    fill_in "Password", :with => user.password
    click_button "Sign in"
    page.should have_content("Signed in as")
    page.should have_link("Users")
    page.should have_link("Sign out")
    click_link("Profile")
    fill_in "Last Name", :with => "new_last%^"
    click_button "Update"
    current_path.should eq(user_path(user))
    page.should have_content("Lastname is invalid")
  end
  
  it "doesn't update user profile with invalid email" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    visit signin_path
    fill_in "Username", :with => user.username
    fill_in "Password", :with => user.password
    click_button "Sign in"
    page.should have_content("Signed in as")
    page.should have_link("Users")
    page.should have_link("Sign out")
    click_link("Profile")
    fill_in "Parents' Email", :with => "lafrance.familyyahoo.com"
    fill_in "Retype Parents' Email", :with => "lafrance.family@yahoo.com"
    click_button "Update"
    current_path.should eq(user_path(user))
    page.should have_content("Email is invalid")
  end
  
  it "doesn't update user profile when email doesn't match confirmation" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    visit signin_path
    fill_in "Username", :with => user.username
    fill_in "Password", :with => user.password
    click_button "Sign in"
    page.should have_content("Signed in as")
    page.should have_link("Users")
    page.should have_link("Sign out")
    click_link("Profile")
    fill_in "Parents' Email", :with => "lafrance.family@yahoo.com"
    fill_in "Retype Parents' Email", :with => "lafrance.family@ygmail.com"
    click_button "Update"
    current_path.should eq(user_path(user))
    page.should have_content("Email doesn't match confirmation")
  end

end
