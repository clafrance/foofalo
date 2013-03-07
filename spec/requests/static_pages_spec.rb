require 'spec_helper'

describe "StaticPages" do
  subject { page }
  
  describe "Home page" do
    before { visit root_path } 
    it { should have_content("Foofalo") }
    it { page.should have_link("Sign up") }
    it { page.should have_link("Sign in") }
    it { page.should have_link("Home") }
    it { page.should have_link("HOME") }
    it { page.should have_link("ABOUT") }
    it { page.should have_link("TERMS") }
    it { should have_selector("title", :text => "Foofalo: Home") }
    it { should have_content("ClickHere to sign in as a guest") }
    it { should have_content("COPYRIGHT @ 2011 FOOFALO.COM ALL RIGHTS RESERVED") }
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
