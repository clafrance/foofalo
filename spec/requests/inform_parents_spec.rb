require 'spec_helper'

describe "InformParents" do
  subject { page }
  
  it "email user when user signup to request parent confirmation" do
    user = Factory(:user)
    visit signup_path
    fill_in "Username", :with => "#{random_letters(5)}"
    fill_in "Password", :with => user.password
    fill_in "Retype Password", :with => user.password_confirmation
    fill_in "First Name", :with => user.firstname
    fill_in "Last Name", :with => user.lastname
    fill_in "Parents' Email", :with => user.email
    fill_in "Retype Parents' Email", :with => user.email
    click_button "Sign up"
    should have_content("You have signed up")
    last_email.to.should include(user.email)
  end
end
