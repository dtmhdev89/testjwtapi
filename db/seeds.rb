# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if !User.exists?
  puts "Create Users"

  5.times do
    User.create username: Faker::Name.name.downcase.gsub(" ", ""),
      password: "123456", age: [*18..40].sample
  end
end

if !Book.exists?
  puts "Create Book"

  50.times do
    Book.create title: Faker::Book.title, author: Faker::Book.author,
      genre: Faker::Book.genre, content: Faker::Lorem.paragraph(sentence_count: [*5..10].sample)
  end
end
