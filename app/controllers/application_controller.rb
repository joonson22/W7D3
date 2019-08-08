class ApplicationController < ActionController::Base

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def login_user(user)
    session[:session_token] = User.reset_session_token!
    @current_user = user
  end

  def logout_user
    session[:session_token] = nil
    @current_user = nil
    current_user.reset_session_token! if logged_in?
  end

  def require_logged_in
    redirect_to sessions_url unless logged_in?
  end

  def require_logged_out
    redirect_to user_url(current_user) if logged_in?
  end
end
