require 'spec_helper'

describe "StaticPages" do
  subject { page }
  
  it "should have correct info" do
    visit root_path
    should have_content("Foofalo") 
    should have_link("Sign up") 
    should have_link("Sign in") 
    should have_link("Home") 
    should have_link("HOME") 
    should have_link("ABOUT") 
    should have_link("TERMS") 
    should have_selector("title", :text => "Foofalo: Home") 
    should have_content("ClickHere to sign in as a guest") 
    should have_content("COPYRIGHT @ 2011 FOOFALO.COM ALL RIGHTS RESERVED") 
    should have_selector("img[src$='/assets/new_joke_1.png']") 
    should have_selector("img[src$='/assets/new_mansters_1.png']") 
    should have_selector("img[src$='/assets/logo60.png']") 
    should have_selector("img[src$='/assets/new_fact_1.png']") 
    should have_selector("img[src$='/assets/new_links_1.png']") 
    should have_selector("img[src$='/assets/new_challenge_1.png']") 
    should have_selector("img[src$='/assets/new_games_1.png']") 
  end
  
  describe "About page" do
    before { visit '/about' }
    it { should have_content("About") }
    it { should have_selector("title", :text => "Foofalo: About") }
  end
  
  describe "Terms page" do
    before { visit '/terms' }
    it { should have_content("Terms") }
    it { should have_selector("title", :text => "Foofalo: Terms") }
  end

end
