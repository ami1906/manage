class ApplicationController < ActionController::Base
  protect_from_forgery

def require_login
  if session[:user_id].nil?
        @message="You must Log-In to access this content"
        redirect_to "/login"
  end
end

def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
end
def isAdmin
    @user=User.find(session[:user_id])
     if @user.role_id == Role::Admin
       true
     else
      false
     end
 end


end
