class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user # make it available to views by passing it as a symble
  helper_method :full_name
  helper_method :random_challenge
  helper_method :jokes_entered_by_user
  helper_method :correct_answers_by_user
  
  
  
  # helper is available to views by default, include make it available to controllers
  include ApplicationHelper
  include SessionsHelper 
  include UsersHelper 
  include StaticPagesHelper
  include JokesHelper
  include LinksHelper
  include ChallengesHelper
  
  
    # def current_user
    #   @current_user ||= User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
    # end

  # private    
  #   def full_name(first, last)
  #     full_name = first + ' ' + last
  #   end
end
