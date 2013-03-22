require 'spec_helper'

describe "JokesPages" do
  subject { page }
  
  describe "Index page" do
    before { 
      visit root_path
    }
  end
  
  it "displays correct info" do
    sign_in_user
    click_link "Jokes"
    current_path.should eq("/jokes")
    should have_selector("h3", :text => "Displayed Jokes")
    should_have_joke_links_for_user
  end
  
  it "creates, edits, views jokes" do
    sign_in_user
    click_link "Jokes"
    current_path.should eq("/jokes")
    should_have_joke_links_for_user
    
    # Create new Joke
    click_link("Enter New Jokes")
    current_path.should eq("/jokes/new")
    should_have_items_after_signin
    should have_content("Enter New Joke")
    should have_content("Name")
    should have_content("Details")
    should have_button("Submit")
    should have_link("Cancel")
    fill_in 'Name', :with => 'Test Joke'
    fill_in 'Details', :with => 'Test Joke details'
    click_button("Submit")
    should have_content("Joke has been created. It will be published after approved.")
    current_path.should eq("/myjokes")
    should_have_items_after_signin
    should_have_joke_links_for_user
    should have_content("My Jokes Being Reviewed")
    should have_content("Test Joke")
    should have_link("Test Joke")
    should have_link("Edit")
    
    # View the joke just created
    click_link("Test Joke")
    should_have_items_after_signin
    should have_content("Test Joke")
    should have_content("Test Joke details")
    should have_content("By")
    should have_content("on")
    click_link("View, Edit My Jokes")
    should_have_items_after_signin
    should_have_joke_links_for_user
    should have_content("My Jokes Being Reviewed")
    should have_content("Test Joke")
    should have_link("Edit")
    
    # edit joke
    click_link("Edit")
    should have_selector("h2", :text => "Edit Joke")
    fill_in 'Name', :with => ("updated name for Joke About Dog")
    fill_in 'Joke details', :with => ("added details for Why does dog cross the street?")
    click_button("Update")
    should have_content("Joke has been Updated")
    
    # View Jokes by Author
    click_link("Jokes by Author")
    should have_selector("h2", :text => "Jokes by Author")
    
    # View my jokes
    click_link("View, Edit My Jokes")
    should have_selector("h2", :text => "My Jokes")
    should_have_items_after_signin
    should_have_joke_links_for_user
    should have_content("My Approved Jokes")
    should have_content("My Jokes Being Reviewed")
    should have_content("My Unapproved Jokes")
    
    # Link to jokes by date
    click_link("01/29/2013")
    should have_selector("h2", :text => "Jokes on 01/29/2013")
    should_have_items_after_signin
    should_have_joke_links_for_user
  end  
end
