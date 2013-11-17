class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # Check whether session is empty or not
  def require_login
    if session[:user_id].nil?
        @message="You must Log-In to access this content"
        redirect_to "/login"
    end
  end

  # Clear cache to avoid navigating back after logout
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
  end

  # Check wether the logged-in user is a Admin or Faculty
  def isAdmin
    @user=User.find(session[:user_id])
      if @user.role_id == Role::Admin
        true
      else
       false
      end
  end
end
