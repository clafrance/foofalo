require 'spec_helper'

describe "Show Users" do
  subject { page }
  
  it "shows all users" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
    displayed_challenge = Factory(:challenge, :user_id => user.id, :author => user.username)
    displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
    display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
    display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
    display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
    sign_in(user)
    click_link("Users")
    should have_content("All Users")
    User.all.each do |user|
      should have_selector('a', text: user.username)
    end
  end
end

describe "EditProfile" do
   subject { page }
  
  it "updates user profile with valid info" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
    displayed_challenge = Factory(:challenge, :user_id => user.id, :author => user.username)
    displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
    display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
    display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
    display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
    sign_in(user)
    click_link("Profile") 
    fill_in "Password", :with => "ssssss"
    fill_in "Retype Password", :with => "ssssss"
    fill_in "First Name", :with => "new_first"
    fill_in "Last Name", :with => "new_last"
    fill_in "Parents' Email", :with => "lafrance.family@yahoo.com"
    fill_in "Retype Parents' Email", :with => "lafrance.family@yahoo.com"
    click_button "Update"
    current_path.should eq(user_path(user))
    should have_content("Profile Updated")
    user.reload.email.should  == "lafrance.family@yahoo.com" 
    user.reload.firstname.should  == "new_first" 
    user.reload.lastname.should  == "new_last"   
  end
  
  it "doesn't update user profile with invalid password" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
    displayed_challenge = Factory(:challenge, :user_id => user.id, :author => user.username)
    displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
    display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
    display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
    display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
    sign_in(user)
    click_link("Profile")
    fill_in "Password", :with => "ssss"
    fill_in "Retype Password", :with => "ssss"
    click_button "Update"
    current_path.should eq(user_path(user))
    should have_content("Password is too short")
  end
  
  it "doesn't update user profile when password doesn't match confirmation" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
    displayed_challenge = Factory(:challenge, :user_id => user.id, :author => user.username)
    displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
    display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
    display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
    display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
    sign_in(user)
    click_link("Profile")
    fill_in "Password", :with => "ssssss"
    fill_in "Retype Password", :with => "sssssss"
    click_button "Update"
    current_path.should eq(user_path(user))
    should have_content("Password doesn't match confirmation")
  end
  
  it "doesn't update user profile with invalid firstname" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
    displayed_challenge = Factory(:challenge, :user_id => user.id, :author => user.username)
    displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
    display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
    display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
    display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
    visit new_session_path
    sign_in(user)
    click_link("Profile")
    fill_in "First Name", :with => "new_first%^"
    click_button "Update"
    current_path.should eq(user_path(user))
    should have_content("Firstname is invalid")
  end
  
  it "doesn't update user profile with invalid lastname" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
    displayed_challenge = Factory(:challenge, :user_id => user.id, :author => user.username)
    displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
    display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
    display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
    display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
    sign_in(user)
    click_link("Profile")
    fill_in "Last Name", :with => "new_last%^"
    click_button "Update"
    current_path.should eq(user_path(user))
    should have_content("Lastname is invalid")
  end
  
  it "doesn't update user profile with invalid email" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
    displayed_challenge = Factory(:challenge, :user_id => user.id, :author => user.username)
    displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
    display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
    display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
    display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
    sign_in(user)
    click_link("Profile")
    fill_in "Parents' Email", :with => "lafrance.familyyahoo.com"
    fill_in "Retype Parents' Email", :with => "lafrance.family@yahoo.com"
    click_button "Update"
    current_path.should eq(user_path(user))
    should have_content("Email is invalid")
  end
   
  it "doesn't update user profile when email doesn't match confirmation" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
    displayed_challenge = Factory(:challenge, :user_id => user.id, :author => user.username)
    displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
    display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
    display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
    display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
    sign_in(user)
    click_link("Profile")
    fill_in "Parents' Email", :with => "lafrance.family@yahoo.com"
    fill_in "Retype Parents' Email", :with => "lafrance.family@ygmail.com"
    click_button "Update"
    current_path.should eq(user_path(user))
    should have_content("Email doesn't match confirmation")
  end
  
  it "does not submit a PUT request to the Users#update action" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
    displayed_challenge = Factory(:challenge, :user_id => user.id, :author => user.username)
    displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
    display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
    display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
    display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
    wrong_user = Factory(:user, :username => "wrppppongusername")
    sign_in(user)
    visit edit_user_path(wrong_user)
    should have_selector('title', text: "Foofalo: Index")
    put user_path(wrong_user)
    should have_selector('title', text: "Foofalo: Index")   
    current_url.should eq(root_url) 
  end
end
