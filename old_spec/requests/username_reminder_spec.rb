require 'spec_helper'

describe "UsernameReminder" do
  it "email user when requesting username reminder" do
    user = Factory(:user)
    visit signin_path
    click_link "username"
    fill_in "Email", :with => user.email
    click_button "Send Username"
    current_path.should eq(root_path)
    page.should have_content("Email sent with username")
    last_email.to.should include(user.email)
  end
  
  it "does not send email with invalid email address" do
    visit signin_path
    click_link "username"
    fill_in "Email", :with => "nobody.wer"
    click_button "Send Username"
    page.should have_content("Invalid email address")
    last_email.should be_nil
  end
end
