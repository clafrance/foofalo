require 'spec_helper'

describe "FunFactPages" do
  subject { page }

  describe "Index page" do
    before { 
      visit root_path
    }
  end

  it "displays correct info for user" do
    sign_in_user
    click_link "Fun Facts"
    current_path.should eq("/fun_facts")
    should have_selector("h2", :text => "Fun Facts")
    should have_content("Total")
    should_have_items_after_signin
    should_have_fun_fact_links_for_user
    should have_content("Fun Fact1")
    should have_content("Best time to pickup shell")
  end

  it "display correct info for admin user" do
    sign_in_admin_user
    click_link("Fun Facts")
    should have_selector("h2", :text => "Fun Facts")
    should_have_fun_fact_links_for_admin 

    # Create new fun fact
    click_link("Enter New Fun Fact") 
    should_have_items_after_signin
    should_have_fun_fact_links_for_admin
    should have_selector("h2", :text => "New Fun Fact")  
    should have_button("Submit")
    should have_link("Cancel")
    fill_in("Name", :with => "The Fun Fact")
    fill_in("Details", :with => "The fun fact details")
    click_button("Submit")

    # show fun fact
    should have_content("Fun fact has been created")
    should have_selector("h2", :text => "The Fun Fact")
    should_have_items_after_signin
    should_have_fun_fact_links_for_admin
    should have_content("The fun fact details")
    should have_link("Edit")
    should have_link("Delete")

    # edit Fun fact
    click_link("Edit")
    should have_selector("h2", :text => "Fun Fact")
    fill_in("Name", :with => "Update The New Fun Fact")
    fill_in("Details", :with => "Update The New Fun Fact details")
    click_button("Update")
    should have_content("Fun fact has been Updated")
    should have_selector("h2", :text => "Update The New Fun Fact")
    should have_content("Update The New Fun Fact details") 

    # Create new fun fact and delete it
    click_link("Enter New Fun Fact") 
    should have_selector("h2", :text => "New Fun Fact")  
    fill_in("Name", :with => "Any name")
    fill_in("Details", :with => "Any details")
    click_button("Submit")
    should have_content("Fun fact has been created")
    click_link("Delete")
    should have_content("Fun fact Any name has been deleted.")
  end
end
