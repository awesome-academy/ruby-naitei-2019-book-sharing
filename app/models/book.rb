class Book < ApplicationRecord
  mount_uploader :picture, ImagesUploader
  scope :order_asc, ->{order name: :asc}

  has_many :author_books
  has_many :authors, through: :author_books, dependent: :destroy
  has_many :book_genres
  has_many :genres, through: :book_genres, dependent: :destroy
  has_many :rates
  has_many :posts, dependent: :destroy

  validates :name, presence: true

  def self.search pattern
    if pattern.blank?
      all
    else
      where("name LIKE ?", "#{pattern}%")
    end
  end

  def average_rate
    book = Book.find_by id: id
    rates = book.rates
    size = rates.size
    total = rates.sum(&:score)
    return total.to_f / size unless size.zero?
  end
end
