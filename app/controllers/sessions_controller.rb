class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user&.authenticate params[:session][:password]
      activated
    else
      flash.now[:danger] = t "danger_login"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def check_remember
    if params[:session][:remember_me] == Settings.user.remember.value
      remember @user
    else
      forget @user
    end
  end

  def activated
    if @user.activated
      log_in @user
      check_remember
      redirect_back_or @user
    else
      flash[:warning] = t "login_activate_message"
      redirect_to root_url
    end
  end
end
