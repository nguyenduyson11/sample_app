class PasswordResetsController < ApplicationController
  before_action :get_user, only: %i(edit update)
  before_action :valid_user, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "reset_email_info"
      redirect_to root_path
    else
      flash.now[:danger] = t "reset_email_danger"
      render :new
    end
  end

  def edit; end

  def update
    if user_params[:password].blank?
      flash[:danger] = t "reset_password_empty"
      redirect_to new_password_reset_path
    elsif @user.update user_params
      flash[:success] = t "reset_password_sucsess"
      redirect_to new_password_reset_path
    else
      render :edit
    end
  end

  def valid_user
    return if @user.activated && @user.authenticated?(:reset, params[:id])

    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "password_reset_expired"
    redirect_to new_password_reset_path
  end

  private
  def get_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t "not_found_user"
    respond_to new_password_reset_path
  end
end
