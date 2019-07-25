20.times do |n|
  Author.create!(
    name: Faker::Name.name,
    descript: Faker::Lorem.paragraph)
end


10.times do |n|
  Genre.create!(
    name: Faker::Book.genre,
    descript: Faker::Lorem.paragraph)
end

20.times do |n|
  Book.create!(
    name: Faker::Book.title,
    page_number: Faker::Number.number(3),
    isbn: Faker::Number.number(9),
    publisher: Faker::Book.publisher,
    publish_date: Faker::Date.between(7.years.ago, Date.today),
    descript: Faker::Lorem.paragraph(1),
    picture: File.open(Rails.root + "public/uploads/image/book_default.jpg"),
  )
end

books = Book.all

books.each do |book|
  AuthorBook.create!(
    book_id: book.id,
    author_id: Faker::Number.between(1,10)
  )
  4.times do |n|
    BookGenre.create!(
      book_id: book.id,
      genre_id: Faker::Number.between(1,10)
    )
  end
end
