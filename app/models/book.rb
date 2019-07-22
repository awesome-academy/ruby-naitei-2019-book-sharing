class Book < ApplicationRecord
  has_many :author_books
  has_many :authors, through: :author_books, dependent: :destroy
  has_many :book_genres
  has_many :genres, through: :book_genres, dependent: :destroy
  has_many :rates
  has_many :posts, dependent: :destroy

  validates :name, presence: true
end
