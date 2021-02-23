module ApplicationHelper
  def full_title page_title
    base_title = t "users.help.text_help_page"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end
end
