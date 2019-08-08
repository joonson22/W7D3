class SessionsController < ApplicationController

  before_action :require_logged_out, only: [:new, :create]
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if user
      login_user(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = "Wrong username/password!!"
      render :new
    end
  end

  def destroy
    logout_user if logged_in?
    redirect_to sessions_url
  end
end
