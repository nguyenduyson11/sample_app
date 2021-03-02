class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("email_title")
  end

  def password_reset
    @greeting = t("email_say")
    mail to: t("email_to")
  end
end
