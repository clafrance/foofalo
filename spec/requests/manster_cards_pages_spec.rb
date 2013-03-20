require 'spec_helper'

describe "MansterCardsPages" do
  subject { page }

  describe "Index page" do
    before { 
      visit root_path
    }
  end

  it "displays correct info for user" do
    sign_in_user
    click_link "Manster Cards"
    current_path.should eq("/manster_cards")
    should have_selector("h2", :text => "Manster Cards")
    should_have_items_after_signin
  end
end

