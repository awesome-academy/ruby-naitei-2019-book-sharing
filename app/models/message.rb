class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  validates :content, presence: true, allow_blank: false
  scope :for_display, ->{order(:created_at).last(50)}

  def mentions
    content.scan(/@(#{User::NAME_REGEX})/).flatten.map do |username|
      User.find_by(username: username)
    end.compact
  end

  def message_time
    created_at.strftime("%l:%M %p")
  end
end
