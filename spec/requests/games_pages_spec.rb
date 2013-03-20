require 'spec_helper'

describe "GamesPages" do
  subject { page }
  
  describe "Index page" do
    before { 
      visit root_path
    }
  end
  
  it "displays correct info for user" do
    sign_in_user
    click_link "Games"
    current_path.should eq("/games")
    should have_selector("h2", :text => "Games")
    should_have_items_after_signin
  end
end
