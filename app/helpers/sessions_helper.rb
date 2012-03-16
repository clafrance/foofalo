module SessionsHelper
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] ||= default)
    clear_return_to
  end
  
  def store_referrer_location
    if request.referrer == signup_url || request.referrer == signup_path 
      session[:return_to] = front_url
    else
      if request.referrer == signin_path || request.referrer == signin_url 
        session[:return_to] = front_url
      else
        session[:return_to] = request.referrer
        #session[:return_to] = request.fullpath
      end
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end
  
  # moved here from application_controller
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
  end
  
  def sign_in_remember(user)
    cookies.permanent[:remember_token] = user.remember_token 
    current_user 
  end
  
  def sign_in(user)
    cookies[:remember_token] = user.remember_token  
    current_user
  end
  
  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  private
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) if @user != current_user
    end
  
    def signed_in_user
      if current_user.nil?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end
    
    def admin_user?
      redirect_to(root_path) if current_user.privilege != 0
    end
    
    def clear_return_to
      session.delete(:return_to)
    end
end
