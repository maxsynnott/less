# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "\n"

puts "Let the seeding begin"

puts "\n"

num_products = 10

puts "Creating #{num_products} products:"
num_products.times do
	product = Product.create(name: Faker::Food.unique.ingredient, description: Faker::Food.description, price: rand(0.001..0.1))

	puts "Created #{product.name}."
end

puts "\n"

email = "admin@example.com"
password = "123456"

admin = User.create(email: email, password: password)

puts "Admin account created with:"
puts "email: #{email}"
puts "password: #{password}"

puts "\n"

cart = Cart.create(user: admin)

puts "Admin cart created."

num_orders = rand(2..5)

products = Product.all.sample(num_orders)

products.each { |product| cart.add_product(product, rand(1..3000)) }

puts "Admin cart populated with #{num_orders} orders."

puts "\n"

puts "Generating containers"

[500, 1000, 1500].each do |i|
	container = Container.create(name: "#{i.to_s}g container", size: i)

	puts "Created #{container.name}"
end