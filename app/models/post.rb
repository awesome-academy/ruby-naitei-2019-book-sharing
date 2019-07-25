class Post < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
