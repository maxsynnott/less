# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

num_products = 10

puts "Creating #{num_products} products:"
num_products.times do
	product_name = Faker::Food.unique.ingredient
	Product.create(name: product_name, description: Faker::Food.description, price: rand(10..3000))

	puts "Created #{product_name}."
end
