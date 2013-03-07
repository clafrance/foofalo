require 'spec_helper'

describe "UsernameReminder" do
  subject { page }
   
  it "emails user when requesting username reminder" do
    user = Factory(:user)
    visit new_session_path
    click_link "Find username"
    fill_in "email", :with => user.email  
    click_button "Send Me Username"   
    current_path.should eq(root_path)
    should have_content("Email sent with username")
    last_email.to.should include(user.email)
  end
  
  it "does not send email with invalid email address" do
    visit new_session_path
    click_link "username"
    fill_in "email", :with => "nobody.wer"
    click_button "Send Me Username"
    should have_content("Invalid email address")
    last_email.should be_nil
  end
end
