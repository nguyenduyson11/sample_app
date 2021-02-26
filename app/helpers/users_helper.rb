module UsersHelper
  def view_admin user
    return unless current_user.admin? && !current_user?(user)

    link_to t("link_delete"), user, method: :delete, data:
      {confirm: t("_user_confirm")}
  end
end
