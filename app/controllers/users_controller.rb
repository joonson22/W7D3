class UsersController < ApplicationController
  before_action :require_logged_in, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.new(user_params)

    if user.save
      login_user(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user
      render :show
    else
      flash.now[:errors] = "user not found"
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:id])

    if @user
      render :edit
    else
      flash.now[:errors] = "User not found"
      render :edit
    end
  end

  def update
    @user = User.find_by(id: params[:id])

    if @user.update_attributes(user_params)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def destroy
    user = User.find_by(id: params[:id])

    if user.destroy
      redirect_to users_url
    else
      flash.now[:errors] = user.errors.full_messages
      render :show
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
