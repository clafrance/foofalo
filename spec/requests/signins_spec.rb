require 'spec_helper'


describe "User Signin" do
  
  subject {page}
  
  it "should have these fields and links" do
    visit new_session_path
    should have_selector('h2', :text=>"Sign in")
    should have_field('Username')
    should have_field('Password')
    should have_content('Forgot your username? Find username')
    should have_content('Forgot your password? Reset password')
    should have_link('Find username')
    should have_link('Reset password')
    should have_field('Remember me')
    should have_button('Sign in')
    should have_link('Cancel')
    should have_content('Click here to sign in as a guest')
    should have_link('Sign up')
    should have_link('Sign in')
    should have_link('HOME')
    should have_link('ABOUT')
    should have_link('TERMS')
  end
  
  it "signs in user with valid info, 'Remember me' not checked" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
    displayed_challenge = Factory(:challenge, :user_id => user.id, :author => user.username)
    displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
    display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
    display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
    display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
    sign_in_successfully(user)
  end
    
  it "should not sign in user when parent hasn't approved" do
    user = Factory(:user)
    sign_in(user)
    should have_content("still waiting for your parents approval")
  end
    
  it "signs in user with 'Remember me' selected" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
    displayed_challenge = Factory(:challenge, :user_id => user.id, :author => user.username)
    displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
    display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
    display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
    display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
    remember_me_sign_in_successfully(user)
  end
    
  it "should not sign in user with invalid username password combination" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    visit new_session_path
    fill_in "Username", :with => user.username
    fill_in "Password", :with => "mmmmmm"
    check("Remember me")
    click_button "Sign in"
    current_path.should eq(sessions_path)
    should have_content("Invalid")  
  end
    
  it "signs user out when clicking 'Sign out' link" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
    displayed_challenge = Factory(:challenge, :user_id => user.id, :author => user.username)
    displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
    display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
    display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
    display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
    sign_in_successfully(user)
    click_link "Sign out"
    should have_link('Sign up')
    should have_link('Sign in')
    should_not have_link("Profile")  
  end
    
  it "links user to other pages when click links" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
    displayed_challenge = Factory(:challenge, :user_id => user.id, :author => user.username)
    displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
    display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
    display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
    display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
    sign_in_successfully(user)
    click_link "Profile"
    current_path.should eq(edit_user_path(user))
    should have_content("Edit") 
    click_link "Users"
    current_path.should eq(users_path)
    should have_content("All")
    click_link "Sign out"
    should have_link('Sign up')
    should have_link('Sign in')
    should_not have_link("Profile")
  end    
end
