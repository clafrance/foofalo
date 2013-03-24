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
    should_have_items_after_signin
  end
end
