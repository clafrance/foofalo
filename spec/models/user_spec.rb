require 'spec_helper'

describe User do
  describe "#send_password_reset" do
    let(:user) { Factory(:user) }
    
    it "generates a unique password_reset_token each time" do
      user.send_password_reset
      last_token = user.password_reset_token
      user.send_password_reset
      user.password_reset_token.should_not eq(last_token)
    end
    
    it "saves the time the password reset was sent" do
      user.send_password_reset
      user.reload.password_reset_sent_at.should be_present
    end
    
    it "delivers email to user" do
      user.send_password_reset
      last_email.to.should include(user.email)
    end
  end
  
  describe "#send_username_reminder" do
    let(:user) { Factory(:user) }
    
    it "delivers email to user" do
      user.send_username_reminder
      last_email.to.should include(user.email)
    end
  end
  
  describe "#send_inform_parents" do
    let(:user) { Factory(:user) }
    
    it "generates a unique inform_parents_token each time" do
      user.send_inform_parents
      last_token = user.inform_parents_token
      user.send_inform_parents
      user.inform_parents_token.should_not eq(last_token)
    end
    
    it "saves the time the inform parents was sent" do
      user.send_inform_parents
      user.reload.inform_parents_sent_at.should be_present
    end
    
    it "delivers email to user" do
      user.send_inform_parents
      last_email.to.should include(user.email)
    end
  end  
end
