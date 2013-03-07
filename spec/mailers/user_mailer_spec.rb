require "spec_helper"

describe UserMailer do
  describe "password_reset" do
    let(:user) { Factory(:user, :password_reset_token => "anything") }
    let(:mail) { UserMailer.password_reset(user) }
  
    it "sends user password reset url" do
      mail.subject.should eq("Password Reset") 
      mail.to.should eq([user.email])
      mail.from.should eq(["foofalo12@gmail.com"])
      mail.body.encoded.should match(edit_password_reset_path(user.password_reset_token))
      mail.body.encoded.should have_content("To reset your password, click here")
    end
  end
  
  describe "username_reminder" do
    let(:user) { Factory(:user) }
    let(:mail) { UserMailer.username_reminder(user) }
  
    it "sends username reminder email" do
      mail.subject.should eq("Username Reminder") 
      mail.to.should eq([user.email])
      mail.from.should eq(["foofalo12@gmail.com"])
      mail.body.encoded.should have_content("Here are the username(s) registered at")
    end
  end
  
  describe "parent_confirm" do
    let(:user) { Factory(:user, :inform_parents_token => "anything") }
    let(:mail) { UserMailer.inform_parents(user) }
  
    it "sends inform parents url" do
      mail.subject.should eq("Needs Parents approval to active the account") 
      mail.to.should eq([user.email])
      mail.from.should eq(["foofalo12@gmail.com"])
      mail.body.encoded.should match(edit_parent_confirm_path(user.inform_parents_token))
      mail.body.encoded.should have_content("By clicking the Approve link below, you and your child agree to our Terms of Use.")
    end
  end
  
  describe "registration_confirmation" do
    let(:user) { Factory(:user, :inform_parents_token => "anything") }
    let(:mail) { UserMailer.registration_confirmation(user) }
  
    it "sends registration confirmation email" do
      mail.subject.should eq("Registration Confirmation") 
      mail.to.should eq([user.email])
      mail.from.should eq(["foofalo12@gmail.com"])
      mail.body.encoded.should have_content("has registered and been approved by parents")
    end
  end
end
