require 'spec_helper'

describe "StaticPages" do
  subject { page }
  
  describe "Home page" do
    before { visit root_path }
    it { should have_content("Foofalo") }
    it { should have_link("Sign up") }
    it { should have_link("Sign in") }
    it { page.should have_link("Sign up now!") }
    it { page.should have_link("Home") }
    it { page.should have_link("About") }
    it { page.should have_link("Terms") }
    it { should have_selector("title", :text => "Foofalo | Home") }
  end
  
  describe "About page" do
    before { visit '/about' }
    it { should have_content("About") }
    it { should have_link("Sign up") }
    it { should have_link("Sign in") }
    it { should have_link("Home") }
    it { should have_link("About") }
    it { should have_link("Terms") }
    it { should have_selector("title", :text => "Foofalo | About") }
  end
  
  describe "Terms page" do
    before { visit '/terms' }
    it { should have_content("Terms") }
    it { should have_link("Sign up") }
    it { should have_link("Sign in") }
    it { should have_link("Home") }
    it { should have_link("About") }
    it { should have_link("Terms") }
    it { should have_selector("title", :text => "Foofalo | Terms") }
  end
end
