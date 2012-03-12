require 'spec_helper'


describe "User Signin" do
  
  it "should have these fields and links" do
    visit signin_path
    page.should have_selector('h1', :text=>"Sign in")
    page.should have_field('Username')
    page.should have_field('Password')
    page.should have_link('forgotten username')
    page.should have_link('forgotten password')
    page.should have_field('Remember me')
    page.should have_button('Sign in')
    page.should have_link('Sign up')
    page.should have_link('Sign in')
    page.should have_link('Home')
    page.should have_link('About')
    page.should have_link('Terms')
  end
  
  it "# sign in user with valid info, 'Remember me' not checked" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    visit signin_path
    fill_in "Username", :with => user.username
    fill_in "Password", :with => user.password
    click_button "Sign in"
    current_path.should eq(root_path)
    page.should have_content("Signed in as #{user.username}")
    page.should have_link("Sign out")
    page.should have_link("Profile")
  end
    
  it "sign in user parent hasn't approved" do
    user = Factory(:user)
    visit signin_path
    fill_in "Username", :with => user.username
    fill_in "Password", :with => user.password
    click_button "Sign in"
    current_path.should eq(root_path)
    page.should have_content("still waiting for your parents approval")
  end
    
  it "sign in user with 'Remember me' selected" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    visit signin_path
    fill_in "Username", :with => user.username
    fill_in "Password", :with => user.password
    check("Remember me")
    click_button "Sign in"
    current_path.should eq(root_path)
    page.should have_content("Signed in as #{user.username}")  
    page.should have_link("Sign out")
    page.should have_link("Profile") 
  end
    
  it "sign in user with invalid username password combination" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    visit signin_path
    fill_in "Username", :with => user.username
    fill_in "Password", :with => "mmmmmm"
    check("Remember me")
    click_button "Sign in"
    current_path.should eq(sessions_path)
    page.should have_content("Invalid")  
  end
    
  it "signs user out when clicking 'Sign out' link" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    visit signin_path
    fill_in "Username", :with => user.username
    fill_in "Password", :with => user.password
    check("Remember me")
    click_button "Sign in"
    current_path.should eq(root_path)
    page.should have_content("Signed in as #{user.username}")  
    page.should have_link("Sign out")
    page.should have_link("Profile")
    click_link "Sign out"
    page.should have_link('Sign up')
    page.should have_link('Sign in')
    page.should_not have_link("Profile")  
  end
    
  it "links user to other pages when click links" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    visit signin_path
    fill_in "Username", :with => user.username
    fill_in "Password", :with => user.password
    check("Remember me")
    click_button "Sign in"
    current_path.should eq(root_path)
    page.should have_content("Signed in as #{user.username}")  
    page.should have_link("Sign out")
    page.should have_link("Profile")
    click_link "Profile"
    current_path.should eq(edit_user_path(user))
    page.should have_content("Edit") 
    click_link "Users"
    current_path.should eq(users_path)
    page.should have_content("All")
    click_link "Sign out"
    page.should have_link('Sign up')
    page.should have_link('Sign in')
    page.should_not have_link("Profile")
  end    
end
