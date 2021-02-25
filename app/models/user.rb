class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true,
    format: {with: VALID_EMAIL_REGEX},
    length: {maximum: Settings.user.email.max_length}
  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
