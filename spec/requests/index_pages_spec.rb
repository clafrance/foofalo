require 'spec_helper'

describe "IndexPages" do
  subject { page }
  
  describe "Index page" do
    before { visit root_path }
    it { should_have_items_before_signin }
  end
  
  it "displays correct info after signing in" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
    displayed_challenge = Factory(:challenge, :user_id => user.id, :author => user.username)
    displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
    displayed_link = Factory(:link, :user_id => user.id)
    display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
    display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
    display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
    sign_in_successfully(user)
    should have_selector("title", :text => "Foofalo: Index")
    should have_link("Google")
    should have_content("Joke of the Day")
    should have_content(displayed_joke.name)
    should have_content(displayed_challenge.name)
    should have_content(displayed_fun_fact.name)
    should have_content("Challenge of the Week")
    should have_content("Fun Facts")
    should have_content("My Links")
    should have_content("Enter your explanation (optional):")
    should have_content("Choose the Correct Answer:")
    should have_button("Submit Answer")
    should have_selector("img[src$='/assets/joke.png']")
    should have_selector("img[src$='assets/challenge.jpg']")
    should have_selector("img[src$='/assets/funfact.jpg']")   
  end
  
  it "submits challenge answers when choose the correct answer" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
    displayed_challenge = Factory(:challenge, :user_id => user.id, :author => user.username)
    displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
    display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
    display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
    display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
    sign_in_successfully(user)
    should_have_items_after_signin
    find(:css, "#answer_[value='#{displayed_challenge.c}']").set(true)
    click_button "Submit Answer"
    should have_content('You are correct!')
    current_path.should eq(index_path)    
  end
  
  it "submits challenge answers when choose the incorrect answer" do
    user = Factory(:user, :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49")
    displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
    displayed_challenge = Factory(:challenge, :user_id => user.id, :author => user.username)
    displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
    displayed_link = Factory(:link)
    display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
    display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
    display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
    sign_in_successfully(user)
    find(:css, "#answer_[value='#{displayed_challenge.a}']").set(true)
    click_button "Submit Answer"
    should have_content('Sorry, the correct answer is c, column c.')
    should have_content("Please try next week's challenge")
    current_path.should eq(index_path)    
  end
  
  
  it "goes to other pages when click links on page" do
    sign_in_user
    click_link "Jokes"
    current_path.should eq("/jokes")
    should_have_items_after_signin
    should have_selector("h2", :text => "Jokes")
    should_have_items_after_signin
    click_link "Home"
    current_path.should eq("/index")
    click_link "Challenges"
    current_path.should eq("/challenges")
    should_have_items_after_signin
    should have_selector("h2", :text => "Challenges")
    click_link "Home"
    current_path.should eq("/index")
    click_link "Fun Facts"
    current_path.should eq("/fun_facts")
    should_have_items_after_signin
    should have_selector("h2", :text => "Fun Facts")
    click_link "Home"
    current_path.should eq("/index")
    click_link "My Links"
    current_path.should eq("/links")
    should_have_items_after_signin
    should have_selector("h2", :text => "My Links")
    click_link "Home"
    current_path.should eq("/index")
    click_link "Manster Cards"
    current_path.should eq("/manster_cards")
    should_have_items_after_signin
    should have_selector("h2", :text => "Manster Cards")
    click_link "Home"
    current_path.should eq("/index")
    click_link "Games"
    current_path.should eq("/games")
    should_have_items_after_signin
    should have_selector("h2", :text => "Games")
    click_link "Home"
    current_path.should eq("/index")
  end
end
