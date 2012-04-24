class StaticPagesController < ApplicationController
  def home
    @title = "Home"
    if current_user.nil?
      render "home"
    else
      get_random_objects
      render "index"
    end
  end
  
  def about
    
  end
  
  def terms
    
  end
  
  def index
    get_random_objects 
  end
  
  private 
  
    def get_random_objects
      @the_random_challenge = random_challenge
      @the_random_fun_fact = random_fun_fact
      @the_random_joke = random_joke
      @display_challenge = DisplayObject.where(:obj_type => "challenge")
      @current_user_answer = Answer.where(:user_id => current_user.id, :challenge_id => @display_challenge[0].obj_id)
      @my_links = Link.find(:all, :order => :name)
    end
end
