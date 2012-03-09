require "spec_helper"

describe UserMailer do
  describe "password_reset" do
    let(:user) { Factory(:user, :password_reset_token => "anything") }
    let(:mail) { UserMailer.password_reset(user) }
  
    it "send user password reset url" do
      mail.subject.should eq("Password Reset") 
      mail.to.should eq([user.email])
      mail.from.should eq(["foofalo12@gmail.com"])
      mail.body.encoded.should match(edit_password_reset_path(user.password_reset_token))
    end
  end
  
  describe "username_reminder" do
    let(:user) { Factory(:user) }
    let(:mail) { UserMailer.username_reminder(user) }
  
    it "send username reminder email" do
      mail.subject.should eq("Username Reminder") 
      mail.to.should eq([user.email])
      mail.from.should eq(["foofalo12@gmail.com"])
      mail.body.encoded.should have_content("Here are the username(s) registered at")
    end
  end
end
