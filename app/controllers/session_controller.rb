class SessionController < ApplicationController
  def login
   if session[:user_id]!=nil
         redirect_to("/students")
   else
     if params[:post]
         @user=User.where(:username => params[:post][:username]).first
         if !@user.nil? && @user.password == params[:post][:password]
          session[:user_id]=@user.id
          session[:display_name]=@user.username
          redirect_to("/students")
         else
          @message="Unauthorized User"
          render "login"
         end
     end
   end
  end

  def logout
   reset_session
   redirect_to "/login"
  end
end
