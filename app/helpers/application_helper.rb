module ApplicationHelper
  def full_title page_title
    base_title = I18n.t "rails"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def like post
    post.likes.find_by user_id: current_user.id
  end

  def author_rate book, user
    rates = book.rates.where(user_id: user.id)
    size = rates.size
    total = rates.sum(&:score)
    return total.to_f / size unless size.zero?
  end

  def rate book
    book.rates.find_by user_id: current_user.id
  end

  def emojify content
    return unless content.present?
    content.to_str.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias(Regexp.last_match(1))
        %(<img alt="#{Regexp.last_match(1)}"
          src="#{"/images/emoji/#{emoji.image_filename}"}"
          style="vertical-align:middle" width="20" height="20" />)
      else
        match
      end
    end.html_safe
  end
end
