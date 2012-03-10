require 'spec_helper'

describe "User Signup" do
  
  it "should have these fields and links" do
    visit '/signup'
    page.should have_selector('h1', :text=>"Sign up")
    page.should have_field('Username')
    page.should have_field('Password')
    page.should have_field('Retype Password')
    page.should have_field('First Name')
    page.should have_field('Last Name')
    page.should have_field("Parents' Email")
    page.should have_field("Retype Parents' Email")
    page.should have_button('Sign up')
    page.should have_link('Sign up')
    page.should have_link('Sign in')
    page.should have_link('Home')
    page.should have_link('About')
    page.should have_link('Terms')
  end
  
  it "sign up user with valid info" do 
    visit "/signup"
    fill_in "Username", :with => random_letters
    fill_in "Password", :with => "foobar"
    fill_in "Retype Password", :with => "foobar"
    fill_in "First Name", :with => "george"
    fill_in "Last Name", :with => "Oba"
    fill_in "Parents' Email", :with => "christie.lafrance@gmail.com"
    fill_in "Retype Parents' Email", :with => "christie.lafrance@gmail.com"
    click_button "Sign up" 
    current_path.should eq(root_path)
    page.should have_content("You have signed up")
  end
  
  it "should fail if username missing" do
    user = Factory(:user)
    visit "/signup"
    fill_in "Username", :with => ""
    fill_in "Password", :with => user.password
    fill_in "Retype Password", :with => user.password_confirmation
    fill_in "First Name", :with => user.firstname
    fill_in "Last Name", :with => user.lastname
    fill_in "Parents' Email", :with => user.email
    fill_in "Retype Parents' Email", :with => user.email_confirmation
    click_button "Sign up"  
    page.should have_content("prohibited this user from being saved")
  end
  
  it "should fail if signup using existing username" do
    user = Factory(:user)
    visit "/signup"
    fill_in "Username", :with => user.username
    fill_in "Password", :with => user.password
    fill_in "Retype Password", :with => user.password_confirmation
    fill_in "First Name", :with => user.firstname
    fill_in "Last Name", :with => user.lastname
    fill_in "Parents' Email", :with => user.email
    fill_in "Retype Parents' Email", :with => user.email_confirmation
    click_button "Sign up"  
    page.should have_content("prohibited this user from being saved")
  end
  
  it "should fail if password doesn't match" do
    user = Factory(:user)
    visit "/signup"
    fill_in "Username", :with => random_letters
    fill_in "Password", :with => "foobarfoobar"
    fill_in "Retype Password", :with => user.password_confirmation
    fill_in "First Name", :with => user.firstname
    fill_in "Last Name", :with => user.lastname
    fill_in "Parents' Email", :with => user.email
    fill_in "Retype Parents' Email", :with => user.email_confirmation
    click_button "Sign up"  
    page.should have_content("prohibited this user from being saved")
  end
   
  it "should fail if there is any field unfilled" do
    visit "/signup"
    click_button "Sign up"  
    page.should have_content("11 errors prohibited this user from being saved")
  end
end
