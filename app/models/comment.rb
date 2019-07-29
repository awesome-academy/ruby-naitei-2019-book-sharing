class Comment < ApplicationRecord
  scope :order_desc, ->{order created_at: :desc}
  belongs_to :user
  belongs_to :post

  validates :content, presence: true, allow_blank: false
end
