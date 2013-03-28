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
    should have_link("Joke About Dog")
    should have_link("01/29/2013")
    should have_link("Delete")
    should have_content("Why does dog cross the street?")
    click_link("01/29/2013")
    should have_selector("h2", :text => "Jokes on 01/29/2013")
    should have_content("Total: 1")
    should have_link("Joke About Dog")
    should_have_joke_links_for_user
  end
  
  it "displays jokes created by current user" do
    user = Factory(:user, :username => "firethorne", :parent_approved => "Yes", :parent_approved_at => "2012-02-29 06:05:49", :privilege => "super_user")
    displayed_joke = Factory(:joke, :user_id => user.id, :author => user.username)
    displayed_challenge = Factory(:challenge, :author_id => user.id, :author => user.username)
    displayed_fun_fact = Factory(:fun_fact, :user_id => user.id, :author => user.username)
    display_object = Factory(:display_object, :obj_id => displayed_challenge.id)
    display_object = Factory(:display_object, :obj_type => "fun_fact", :obj_id => displayed_fun_fact.id)
    display_object = Factory(:display_object, :obj_type => "joke", :obj_id => displayed_joke.id)
    sign_in(user)
    click_link "Jokes"
    click_link("firethorne")
    should have_selector("h2", :text => "Jokes by firethorne")
    should have_content("Total: 1")
    should have_link("Joke About Dog")   
    click_link("Jokes by Authors") 
    should have_selector("h2", :text => "Jokes by Authors")
    should have_content("By firethorne (1)")
    should have_link("Joke About Dog")
    should have_link("01/29/2013")
    # save_and_open_page
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
  
  it "prove, unapprove jokes" do
    sign_in_admin_user
    should_have_items_after_signin
    click_link("Jokes")
    should_have_joke_links_for_admin
    should have_content("Unreviewed Jokes (0)")
    should have_content("Unapproved Jokes (0)")
    should have_content("Approved Jokes (0)")
    should have_content("Displayed Jokes (1)")
    
    # Create joke1
    click_link("Enter New Jokes")
    should_have_items_after_signin
    should_have_joke_links_for_admin
    should have_selector("h2", :text => "Enter New Joke")
    should have_content("Joke Name")
    should have_content("Joke Details")
    should have_button("Submit")
    should have_link("Cancel")
    fill_in("Joke Name", :with => "Joke1")
    fill_in("Joke Details", :with => "Joke1 details")
    click_button("Submit")
    should have_selector("h2", :text => "My Jokes ( Total: 2 )")
    should have_content("My Approved Jokes (1)")
    should have_content("My Jokes Being Reviewed (1)")
    should have_content("My Unapproved Jokes (0)")
    should have_content("My Displayed Jokes")
    
    # Approve Joke
    click_link("Joke1")
    should have_selector("h2", :text => "Joke1")
    should have_button("Approve")
    should have_button("Unapprove")
    should have_link("Cancel")
    click_button("Approve")
    should have_selector("h2", :text => "Jokes")
    should have_content("Approved Jokes (1)")
    should have_content("Unreviewed Jokes (0)")
    
    # Create joke2
    click_link("Enter New Jokes")
    should_have_items_after_signin
    should_have_joke_links_for_admin
    should have_selector("h2", :text => "Enter New Joke")
    should have_content("Joke Name")
    should have_content("Joke Details")
    should have_button("Submit")
    should have_link("Cancel")
    fill_in("Joke Name", :with => "Joke2")
    fill_in("Joke Details", :with => "Joke2 details")
    click_button("Submit")
    
    # save_and_open_page
    should have_selector("h2", :text => "My Jokes ( Total: 3 )")
    should have_content("My Approved Jokes (1)")
    should have_content("My Jokes Being Reviewed (1)")
    should have_content("My Unapproved Jokes (0)")
    should have_content("My Displayed Jokes (1)")
    
    # Unapprove Joke
    click_link("Joke2")
    should have_selector("h2", :text => "Joke2")
    should have_button("Approve")
    should have_button("Unapprove")
    should have_link("Cancel")
    click_button("Unapprove")
    should have_selector("h2", :text => "Jokes")
    should have_content("( Total: 3 )")
    should have_content("Unreviewed Jokes (0)")
    should have_content("Approved Jokes (1)")
    should have_content("Unapproved Jokes (1)")
    should have_content("Displayed Jokes (1)")
  end
   
  it "Delete jokes as admin" do
    sign_in_admin_user
    should_have_items_after_signin
    click_link("Jokes")
    should_have_joke_links_for_admin
    
    # Create joke3
    click_link("Enter New Jokes")
    should_have_items_after_signin
    should_have_joke_links_for_admin
    should have_selector("h2", :text => "Enter New Joke")
    should have_content("Joke Name")
    should have_content("Joke Details")
    should have_button("Submit")
    should have_link("Cancel")
    fill_in("Joke Name", :with => "Joke3")
    fill_in("Joke Details", :with => "Joke3 details")
    click_button("Submit")
    should have_selector("h2", :text => "My Jokes ( Total: 2 )")
    should have_content("My Approved Jokes (1)")
    should have_content("My Jokes Being Reviewed (1)")
    should have_content("My Unapproved Jokes (0)")
    should have_content("My Displayed Jokes")
    
    # Delete Joke
    click_link("Manage Jokes")
    should have_selector("h2", :text => "Jokes")
    should have_content("( Total: 2 )")
    should have_link("Delete")
    click_link("Delete")
    should have_content("Joke Joke3 has been deleted.")
    should have_selector("h2", :text => "Jokes")
    should have_content("( Total: 1 )")
  end
    
end
