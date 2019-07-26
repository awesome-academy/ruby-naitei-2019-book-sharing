module ApplicationHelper
  def full_title page_title
    base_title = I18n.t "rails"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def like post
    post.likes.find_by user_id: current_user.id
  end
end
