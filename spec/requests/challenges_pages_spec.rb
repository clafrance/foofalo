require 'spec_helper'

describe "ChallengesPages" do
  subject { page }
  
  describe "Index page" do
    before { 
      visit root_path
    }
  end
  
  it "displays correct info for user" do
    sign_in_user
    click_link "Challenges"
    current_path.should eq("/challenges")
    should have_selector("h2", :text => "Challenges")
    should_have_challenge_links_for_user
  end
  
  it "display correct info for admin user" do
    sign_in_admin_user
    click_link("Challenges")
    should have_selector("h2", :text => "Challenges")
    should_have_challenge_links_for_admin 
    
    # Create new challenge
    click_link("Enter New Challenge") 
    should_have_items_after_signin
    should_have_challenge_links_for_admin
    should have_selector("h2", :text => "New Challenge")  
    should have_content("Answer Options")
    should have_selector("label", :text => "Choice a")
    should have_selector("label", :text => "Choice b")
    should have_selector("label", :text => "Choice c")
    should have_selector("label", :text => "Choice d")
    should have_selector("label", :text => "Correct Answer")
    should have_selector("option", :text => "a")
    should have_selector("option", :text => "b")
    should have_selector("option", :text => "c")
    should have_selector("option", :text => "d")
    should have_selector("label", :text => "Explanation")
    should have_button("Submit")
    should have_link("Cancel")
    fill_in("Name", :with => "New Challenge")
    fill_in("Details", :with => "New Challenge details")
    fill_in("Choice a", :with => "choice a")
    fill_in("Choice b", :with => "choice b")
    fill_in("Choice c", :with => "choice c")
    fill_in("Choice d", :with => "choice d")
    select('a', :from => 'Correct Answer')
    fill_in("Explanation", :with => "New challenge explanation")
    click_button("Submit")
    
    # show challenge
    should have_content("Challenge has been created")
    should have_selector("h2", :text => "New Challenge")
    should_have_items_after_signin
    should_have_challenge_links_for_admin
    should have_content("New Challenge details")
    should have_link("Edit")
    should have_link("Delete")
    
    # edit challenge
    click_link("Edit")
    should have_selector("h2", :text => "Edit Challenge")
    fill_in("Name", :with => "Update New Challenge")
    fill_in("Details", :with => "Update New Challenge details")
    fill_in("Choice a", :with => "choice aa")
    fill_in("Choice b", :with => "choice bb")
    fill_in("Choice c", :with => "choice cc")
    fill_in("Choice d", :with => "choice dd")
    select('b', :from => 'Correct Answer')
    fill_in("Explanation", :with => "Updated explanation.")
    click_button("Update")
    should have_content("Challenge has been Updated")
    click_link("Edit")
    # need to figure out hoe to verify options selected.
    should have_content("Update New Challenge")
    should have_content("Update New Challenge details")  
    
    # Create new challenge and delete it
    click_link("Enter New Challenge") 
    should have_selector("h2", :text => "New Challenge")  
    should have_content("Answer Options")
    fill_in("Name", :with => "New Challenge 1")
    fill_in("Details", :with => "New Challenge details 1")
    fill_in("Choice a", :with => "choice aaa")
    fill_in("Choice b", :with => "choice bbb")
    fill_in("Choice c", :with => "choice ccc")
    fill_in("Choice d", :with => "choice ddd")
    select('c', :from => 'Correct Answer')
    fill_in("Explanation", :with => "New challenge explanation 1")
    click_button("Submit")
    click_link("Delete")
    should have_content("Challenge New Challenge 1 has been deleted.")
  end
  
  
  
end
