require 'spec_helper'

describe User do

  describe "test methods in user model" do
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
  
    describe "#send_parent_confirm" do
      let(:user) { Factory(:user) }
  
      it "sets the 'parent_approved' to Yes" do
        user.send_parent_confirm
        user.reload.parent_approved.should eq("Yes")
      end
  
      it "sets the parent_approved_atto current time" do
        user.send_parent_confirm
        user.reload.parent_approved_at.should be_present
      end
  
      it "delivers email to user" do
        user.send_parent_confirm
        last_email.to.should include(user.email)
      end
    end
  end
  
  describe "test user validations" do
    before do
      @user = User.new(:username => "cg", :password => "foobar", 
      :password_confirmation => "foobar", :firstname => "curious", :lastname => "George",
      :email => "gclafrance@gmail.com", :email_confirmation => "gclafrance@gmail.com") 
    end
      
    subject { @user }
    
    it { should respond_to(:username) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:firstname) }
    it { should respond_to(:lastname) }
    it { should respond_to(:email) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:authenticate) }
    it { should be_valid }
    
    describe "when username is not present" do
      before { @user.username = " " }
      it { should_not be_valid }
    end
    
    describe "when valid username is present" do
      before { @user.username = "aaa" }
      it { should be_valid }
    end
    
    describe "when username is too long" do
      before { @user.username = "a" * 51 }
      it { should_not be_valid }
    end
    
    describe "when password is not present" do
      before { @user.password = " " }
      it { should_not be_valid }
    end
    
    describe "when password is too short" do
      before { @user.password = "a" * 5 }
      it { should_not be_valid }
    end
    
    describe "when password is too long" do
      before { @user.password = "a" * 17 }
      it { should_not be_valid }
    end
    
    describe "when password doesn't match confirmation" do
      before { @user.password_confirmation = "mismatch" }
      it { should_not be_valid }
    end

    describe "when password confirmation is empty" do
      before { @user.password_confirmation = "" }
      it { should_not be_valid }
    end
    
    
    describe "return value of authenticate method" do
      before { @user.save }
      let(:found_user) { User.find_by_username(@user.username) }

      describe "with valid password" do
        it { should == found_user.authenticate(@user.password) }
      end

      describe "with invalid password" do
        let(:user_for_invalid_password) { found_user.authenticate("invalid") }

        it { should_not == user_for_invalid_password }
        specify { user_for_invalid_password.should be_false }
      end
    end
    
    describe "when firstname is not present" do
      before {@user.firstname = " " }
      it { should_not be_valid }
    end
    
    describe "when firstname is too long" do
      before {@user.firstname = "a" * 51 }
      it { should_not be_valid }
    end
    
    describe "when lastname is not present" do
      before {@user.lastname = " " }
      it { should_not be_valid }
    end
    
    describe "when lastname is too long" do
      before {@user.lastname = "a" * 51 }
      it { should_not be_valid }
    end
    
    describe "when email is not present" do
      before { @user.email = " " }
      it { should_not be_valid }
    end
    
    describe "when email format is invalid" do
      invalid_emails =  %w[user@foo,com user_at_foo.org example.user@foo.]
      invalid_emails.each do |invalid_email|
        before { @user.email = invalid_email, @user.email_confirmation = invalid_email }
        it { should_not be_valid }
      end
    end
    
    describe "when email format is valid" do
      valid_addresses = %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      valid_addresses.each do |valid_address|
        before do
          @user.email = valid_address
          @user.email_confirmation = valid_address
        end
        it { should be_valid }
      end 
    end
    
    describe "when username is already taken" do
      before do
        user_with_same_username = @user.dup
        user_with_same_username.username = @user.username.upcase
        user_with_same_username.save
      end
      it { should_not be_valid }
    end
  end 
end
