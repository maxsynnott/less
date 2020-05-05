puts "Let the seeding begin"

num_products = 10

num_products.times do
	Product.create(
		name: Faker::Food.unique.ingredient,
		description: Faker::Food.description,
		price: rand(0.001..0.1)
	)
end

puts "Created #{num_products} products"

email = "user@example.com"
password = "123456"

user = User.create(email: email, password: password, cart: Cart.new)

puts "User account created with:"
puts "email: #{email}"
puts "password: #{password}"

user.addresses.create(
	user_id: user.id,
	street: "Rudi-Dutschke-Straße",
	house_number: "26",
	recipient: "Mr. user",
	postal_code: "10969",
	city: "Berlin",
	state: "Berlin",
	country: "DE",
	notes: "Knock thrice"
)

puts "Created user address"

num_orders = rand(2..5)

products = Product.all.sample(num_orders)

products.each { |product| user.cart.add_product(product, rand(1..3000)) }

puts "User cart populated with #{num_orders} orders."

container_sizes = [500, 1000, 1500]

container_sizes.each { |size| Container.create(name: "#{size.to_s}g container", size: size) }

puts "Generated #{container_sizes.length} containers"

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?