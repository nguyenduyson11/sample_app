class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_relationship, only: :destroy
  before_action :find_user, only: :create

  def create
    current_user.follow(@user)
    respond
  end

  def destroy
    @user = @relationship.followed
    current_user.unfollow(@user)
    respond
  end

  private

  def find_relationship
    @relationship = Relationship.find_by(id: params[:id])
    return if @relationship

    flash[:danger] = t("not_found")
    redirect_to root_path
  end

  def find_user
    @user = User.find_by(id: params[:followed_id])
    return if @user

    flash[:danger] = t("not_found")
    redirect_to root_path
  end

  def respond
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end
end
