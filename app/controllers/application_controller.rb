class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user # make it available to views by passing it as symble
  
  # helper is available to views by default, include make it available to controllers
  #include SessionsHelper 
  
  private
  
    def current_user
      @current_user ||= User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
    end
end
