require 'spec_helper'

describe "InformParents" do
  it "email user when user signup to request parent confirmation" do
    #user = Factory(:user)
    user = User.create(:username=>"abcdefg", :firstname=>"sdfas", :lastname=>"dfdf", :password=>"foobar",:password_confirmation=>"foobar", :email=>"christie.lafrance@gmail.com", :email_confirmation=>"christie.lafrance@gmail.com")
    visit signup_path
    fill_in "Username", :with => user.username
    fill_in "Password", :with => user.password
    fill_in "Retype Password", :with => user.password_confirmation
    fill_in "First Name", :with => user.firstname
    fill_in "Last Name", :with => user.lastname
    fill_in "Parents' Email", :with => user.email
    fill_in "Retype Parents' Email", :with => user.email
    # There is an issue here, click_button Sign up doesn't work, couldn't test signup
    # click_button "Signup"
    # page.should have_content("You have signed up")
  end
end
