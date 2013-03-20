require 'spec_helper'

describe "MyLinksPages" do

  subject { page }

  describe "Index page" do
    before { 
      visit root_path
    }
  end

  it "displays correct info for user" do
    sign_in_user
    click_link "My Links"
    current_path.should eq("/links")
    should have_selector("h2", :text => "My Links")
    should_have_my_link_links_for_user
  end

  it "display correct info for user" do
    sign_in_admin_user
    click_link("My Links")
    should have_selector("h2", :text => "My Links")
    should_have_my_link_links_for_user 

    # Create new link
    click_link("Create New Links") 
    should_have_items_after_signin
    should_have_my_link_links_for_user
    should have_selector("h2", :text => "Enter New Link") 
    fill_in("Link Name", :with => "google")
    fill_in("URL", :with => "google.com")
    # select("option value", :from => "label name")
    select("Home Work", :from => "link[category]")
    should have_link("Cancel")
    click_button("Submit")

    # show link
    should have_content("Link has been created")
    should have_selector("h2", :text => "My Links")
    should_have_items_after_signin
    should_have_my_link_links_for_user
    should have_content("Home Work")
    should have_link("google")

    # edit link
    click_link("Edit, Delete Links")
    should have_selector("h2", :text => "Manage Links")
    should_have_items_after_signin
    should_have_my_link_links_for_user
    should have_link("google")
    should have_link("Edit")
    should have_link("Delete")
    click_link("Edit")
    fill_in("Link Name", :with => "Update The New Link")
    fill_in("URL", :with => "yahoo.com")
    select("School Work", :from => "link[category]")
    click_button("Update")
    should have_content("Link has been Updated")
    should have_selector("h2", :text => "My Links")
    should have_content("School Work")
    should have_link("Update The New Link") 

    # Create new link and delete it
    click_link("Edit, Delete Links") 
    should have_selector("h2", :text => "Manage Links")  
    should have_link("google")
    click_link("Delete")
    should have_content("Link google has been deleted.")
  end
end


