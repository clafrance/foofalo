require 'spec_helper'

describe "StaticPages" do
  subject { page }
  
  describe "Home page" do
    before { visit root_path } 
    it { should have_content("Foofalo") }
    it { page.should have_link("Sign up now!") }
    it { should have_selector("title", :text => "Foofalo | Home") }
    should_have_links_before_signin
  end
  
  describe "About page" do
    before { visit '/about' }
    it { should have_content("About") }
    it { should have_selector("title", :text => "Foofalo | About") }
    should_have_links_before_signin
  end
  
  describe "Terms page" do
    before { visit '/terms' }
    it { should have_content("Terms") }
    it { should have_selector("title", :text => "Foofalo | Terms") }
    should_have_links_before_signin
  end
end
