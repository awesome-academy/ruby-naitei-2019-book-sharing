class Post < ApplicationRecord
  scope :order_desc, ->{order created_at: :desc}
  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  scope :create_desc, ->{order(created_at: :desc)}
  scope :user_posts, ->(id){where(user_id: id)}
  validates :user_id, presence: true

  validates :content, :title, presence: true, allow_blank: false

  def count_like
    post = Post.find_by id: id
    likes = post.likes
    likes.size
  end
end
