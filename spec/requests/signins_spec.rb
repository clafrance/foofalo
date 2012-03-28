require 'spec_helper'


describe "User Signin" do
  
  # subject {page}
  # 
  # it "should have these fields and links" do
  #   visit signin_path
  #   should have_selector('h1', :text=>"Sign in")
  #   should have_field('Username')
  #   should have_field('Password')
  #   should have_link('forgotten username')
  #   should have_link('forgotten password')
  #   should have_field('Remember me')
  #   should have_button('Sign in')
  #   should have_link('Sign up')
  #   should have_link('Sign in')
  #   should have_link('Home')
  #   should have_link('About')
  #   should have_link('Terms')
  # end
  # 
  # it "signs in user with valid info, 'Remember me' not checked" do
  #   user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
  #   sign_in_successfully(user)
  # end
  #   
  # it "signs in user parent hasn't approved" do
  #   user = Factory(:user)
  #   sign_in(user)
  #   should have_content("still waiting for your parents approval")
  # end
  #   
  # it "signs in user with 'Remember me' selected" do
  #   user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
  #   remember_me_sign_in_successfully(user)
  # end
  #   
  # it "signs in user with invalid username password combination" do
  #   user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
  #   visit signin_path
  #   fill_in "Username", :with => user.username
  #   fill_in "Password", :with => "mmmmmm"
  #   check("Remember me")
  #   click_button "Sign in"
  #   current_path.should eq(sessions_path)
  #   should have_content("Invalid")  
  # end
  #   
  # it "signs user out when clicking 'Sign out' link" do
  #   user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
  #   sign_in_successfully(user)
  #   click_link "Sign out"
  #   should have_link('Sign up')
  #   should have_link('Sign in')
  #   should_not have_link("Profile")  
  # end
  #   
  # it "links user to other pages when click links" do
  #   user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
  #   sign_in_successfully(user)
  #   click_link "Profile"
  #   current_path.should eq(edit_user_path(user))
  #   should have_content("Edit") 
  #   click_link "Users"
  #   current_path.should eq(users_path)
  #   should have_content("All")
  #   click_link "Sign out"
  #   should have_link('Sign up')
  #   should have_link('Sign in')
  #   should_not have_link("Profile")
  # end    
end
