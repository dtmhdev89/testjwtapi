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

if !Recipe.exists?
  9.times do |i|
    Recipe.create(
      name: "Recipe #{i + 1}",
      ingredients: '227g tub clotted cream, 25g butter, 1 tsp cornflour,100g parmesan, grated nutmeg, 250g fresh fettuccine or tagliatelle, snipped chives or chopped parsley to serve (optional)',
      instruction: 'In a medium saucepan, stir the clotted cream, butter, and cornflour over a low-ish heat and bring to a low simmer. Turn off the heat and keep warm.'
    )
  end
end
