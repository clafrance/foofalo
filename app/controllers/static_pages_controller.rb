class StaticPagesController < ApplicationController
  def home
  end
  
  def about
    
  end
  
  def terms
    
  end
  
  def index
    @the_random_challenge = random_challenge
    @the_random_fun_fact = random_fun_fact
    @the_random_joke = random_joke
    #@my_links = Link.find(:all, :order => :name)
  end
end
