module SessionsHelper
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] ||= default)
    clear_return_to
  end

  def store_location
    session[:return_to] = request.fullpath
  end
  
  def store_referrer_location
    if request.referrer == signup_url || request.referrer == signup_path 
        session[:return_to] = root_url
    else
      if request.referrer == signin_path || request.referrer == signin_url
        session[:return_to] = root_url
      else
        session[:return_to] = request.referrer
      end
    end
  end

  private
    
    def clear_return_to
      session.delete(:return_to)
    end
end
