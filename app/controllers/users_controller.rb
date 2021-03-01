class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :find_user, except: %i(index create new)
  before_action :correct_user, only: %i(edit update)

  def index
    @users = User.paginate(page: params[:page],
      per_page: params[:per_page] || Settings.user.page.limit)
  end

  def show
    @microposts = @user.microposts.paginate(page: params[:page],
      per_page: params[:per_page] || Settings.user.page.limit)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t("check_email")
      redirect_to root_url
    else
      flash.now[:error] = t "message_register_error"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "profile_message"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user_delete_s"
    else
      flash[:danger] = t "user_delete_e"
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end

  def correct_user
    redirect_to root_url unless current_user?(@user)
  end

  def find_user
    @user = User.find_by(id: params[:id])
    return if @user

    flash[:error] = t "message_show_error"
    redirect_to new_user_path
  end
end
