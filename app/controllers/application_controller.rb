class ApplicationController < ActionController::Base 
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    redirect_to 'sessions/new' unless session[:user_id]
  end

  def require_current_user
    user = User.find_by(id: params[:id])
    redirect_to current_user if current_user != user
    # redirect_to "/users/#{session[:user_id]}" if session[:user_id].to_s != params[:id].to_s
  end
end
