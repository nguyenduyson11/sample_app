class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :name, precedence: true
  validates :email, presence: true, length:
    {maximum: Settings.user.email.max_length},
    format: {with: VALID_EMAIL_REGEX}
  has_secure_password
  before_save :downcase_email

  private

  def downcase_email
    email.downcase!
  end
end
