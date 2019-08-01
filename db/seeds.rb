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

User.create!([
  {email: "vutuananhsama@gmail.com", name: "Anh",
   password: "1234567", password_confirmation: "1234567",
  },
  {email: "tuananh77717@gmail.com", name: "Anh",
   password: "1234567", password_confirmation: "1234567",
  },
  {email: "vu.tuan.anhb@sun-asterisk.com", name: "Anh",
   password: "1234567", password_confirmation: "1234567",
  },
  {email: "abc@gamil.com", name: "Anh",
   password: "1234567", password_confirmation: "1234567",
  },
  {email: "123@gmail.com", name: "Anh",
   password: "1234567", password_confirmation: "1234567",
  },
])

58.times do |n|
  User.create!(
    email: Faker::Name.first_name+n.to_s+"@gmail.com",
    name: Faker::Name.name,
    password: "1234567", password_confirmation: "1234567",
  )
end

Post.create!([
  {title: Faker::Lorem.sentence,
  content: Faker::Lorem.paragraph(20),
  user_id: 1,
  book_id: 1},
  {title: Faker::Lorem.sentence,
  content: Faker::Lorem.paragraph(20),
  user_id: 1,
  book_id: 2},
  {title: Faker::Lorem.sentence,
  content: Faker::Lorem.paragraph(20),
  user_id: 1,
  book_id: 3},
  {title: Faker::Lorem.sentence,
  content: Faker::Lorem.paragraph(20),
  user_id: 1,
  book_id: 4},
  {title: Faker::Lorem.sentence,
  content: Faker::Lorem.paragraph(20),
  user_id: 1,
  book_id: 5},
  {title: Faker::Lorem.sentence,
  content: Faker::Lorem.paragraph(20),
  user_id: 3,
  book_id: 2},
  {title: Faker::Lorem.sentence,
  content: Faker::Lorem.paragraph(20),
  user_id: 2,
  book_id: 3},
  {title: Faker::Lorem.sentence,
  content: Faker::Lorem.paragraph(20),
  user_id: 3,
  book_id: 5},
])

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
