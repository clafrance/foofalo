module SessionsHelper
  
  def redirect_back_or(default)
    redirect_to(store_referrer_location ||= default)
    clear_return_to
  end
  
  def store_referrer_location
    if request.referrer == new_user_url || request.referrer == new_user_path 
      session[:return_to] = index_url
    else
      # if request.referrer == signin_path || request.referrer == signin_url 
      if request.referrer == new_session_path || request.referrer == new_session_url
        session[:return_to] = index_url
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
    
  def non_current_users
    users = User.all
    users.reject { |u| u.id == current_user.id }   
  end
  
  def admin_or_superuser?
    current_user.privilege == "admin" or current_user.privilege == "super_user"
  end
  
  def admin?
    current_user.privilege == "admin"
  end
  
  def super_user?
    current_user.privilege == "super_user"
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
      redirect_to(root_url) if @user != current_user
    end
  
    def signed_in_user
      if current_user.nil?
        store_location
        redirect_to new_session_url, notice: "Please sign in."
      end
    end
    
    def admin_user?
      if current_user.privilege != "admin" 
        if current_user.privilege != "super_user"
          redirect_to store_referrer_location ||= root_url
        end 
      end
    end
    
    def admin_user
      if current_user.privilege != "admin" 
        if current_user.privilege != "super_user"
          redirect_to store_referrer_location ||= root_url
        end
      else
        current_user
      end
    end
    
    def clear_return_to
      session.delete(:return_to)
    end
end
