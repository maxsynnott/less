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
	product = Product.create(name: Faker::Food.unique.ingredient, description: Faker::Food.description, price: rand(10..3000))

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

num_orders.times do
	Order.create(product_id: Product.all.sample.id, cart_id: cart.id, quantity: rand(1..10000))
end

puts "Admin cart populated with #{num_orders} orders."

puts "\n"

puts "Generating containers"

[500, 1000, 1500].each do |i|
	container = Container.create(name: "#{i.to_s}g container", size: i)

	puts "Created #{container.name}"
end