class Post < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  scope :create_desc, ->{order(created_at: :desc)}
  scope :user_posts, ->(id){where(user_id: id)}
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.content_value}
end
