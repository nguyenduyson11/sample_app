class Micropost < ApplicationRecord
  belongs_to :user
  scope :newest, ->{order(created_at: :desc)}
  has_one_attached :image
  validates :user_id, presence: true
  validates :content, presence: true,
   length: {maximum: Settings.micropost.content.length}
  validates :image, content_type: {in: %w(image/jpeg image/gif image/png),
                                   message:
                                    I18n.t("microposts.micropost_image1")},
   size: {less_than: 5.megabytes, message:
    I18n.t("microposts.micropost_image2")}

  def display_image
    mage.variant resize_to_limit: [Settings.image.size, Settings.image.size]
  end
end
