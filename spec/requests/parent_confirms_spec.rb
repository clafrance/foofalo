require 'spec_helper'

# describe "ParentConfirms" do
#   it "email user when user signup to request parent confirmation" do
#     user = Factory(:user)
#     visit signup_path
#     fill_in "Username", :with => user.username
#     fill_in "Password", :with => user.password
#     fill_in "Retype Password", :with => user.password
#     fill_in "First Name", :with => user.firstname
#     fill_in "Last Name", :with => user.lastname
#     fill_in "Parents' Email", :with => user.email
#     fill_in "Retype Parents' Email", :with => user.email
#     click_button "Sign up"
#     save_and_open_page
#     #current_path.should eq(root_url)
#     #page.should have_content("You have signed up. Your parents should receive an email")
#     # last_email.to.should include(user.email)
#   end
# end
