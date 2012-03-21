require 'spec_helper'

describe "User Signup" do
  subject { page }
  
  describe "signup pages" do
    before { visit '/signup' }
    it { should have_selector('h1', :text=>"Sign up") }
    it { should have_field('Username') }
    it { should have_field('Password') }
    it { should have_field('Retype Password') }
    it { should have_field('First Name') }
    it { should have_field('Last Name') }
    it { should have_field("Parents' Email") }
    it { should have_field("Retype Parents' Email") }
    it { should have_button('Sign up') }
    it { should have_link('Sign up') }
    it { should have_link('Sign in') }
    it { should have_link('Home') }
    it { should have_link('About') }
    it { should have_link('Terms') }
    it { page.should have_link("Terms and Use") }
    it { page.should have_content('By clicking the Sign Up button, you agree to our Terms and Use.') }
  end
  
  it "should sign up user with valid info, send inform parents email" do
    user = Factory(:user)
    visit "/signup"
    fill_in "Username", :with => random_letters(5)
    fill_in "Password", :with => user.password
    fill_in "Retype Password", :with => user.password_confirmation
    fill_in "First Name", :with => user.firstname
    fill_in "Last Name", :with => user.lastname
    fill_in "Parents' Email", :with => user.email
    fill_in "Retype Parents' Email", :with => user.email_confirmation
    expect do
      click_button "Sign up"
    end.to change(User, :count).by(1)
    # click_button "Sign up" 
    current_path.should eq(root_path)
    should have_content("You have signed up")
    last_email.to.should include(user.email)
  end
  
  it "should fail if username missing, not send inform parents email" do
    user = Factory(:user)
    visit "/signup"
    fill_in "Username", :with => ""
    fill_in "Password", :with => user.password
    fill_in "Retype Password", :with => user.password_confirmation
    fill_in "First Name", :with => user.firstname
    fill_in "Last Name", :with => user.lastname
    fill_in "Parents' Email", :with => user.email
    fill_in "Retype Parents' Email", :with => user.email_confirmation
    # initial = User.count
    # click_button "Sign up"  
    # final = User.count
    # initial.should == final
    expect { click_button "Sign up" }.not_to change(User, :count)
    should have_content("There were problems with the following fields:")
    last_email.should be_nil
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
    should have_content("There were problems with the following fields:")
    last_email.should be_nil
  end
  
  it "should fail if password doesn't match" do
    user = Factory(:user)
    visit "/signup"
    fill_in "Username", :with => random_letters(5)
    fill_in "Password", :with => "foobarfoobar"
    fill_in "Retype Password", :with => user.password_confirmation
    fill_in "First Name", :with => user.firstname
    fill_in "Last Name", :with => user.lastname
    fill_in "Parents' Email", :with => user.email
    fill_in "Retype Parents' Email", :with => user.email_confirmation
    click_button "Sign up"  
    should have_content("There were problems with the following fields:")
    last_email.should be_nil
  end
   
  it "should fail if there is any field unfilled" do
    visit "/signup"
    click_button "Sign up"  
    should have_content("There were problems with the following fields:")
    last_email.should be_nil
  end
end
