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

num_orders = rand(2..5)

products = Product.all.sample(num_orders)

products.each { |product| user.cart.add_product(product, rand(1..3000)) }

puts "User cart populated with #{num_orders} orders."

containers = [
	{
		name: 'Small glass jar',
		size: 500,
		price: 1.00
	},
	{
		name: 'Medium glass jar',
		size: 1000,
		price: 2.00
	},
	{
		name: 'Large glass jar',
		size: 1500,
		price: 3.00
	}
]

containers.each { |container| Container.create(container) }

puts "Generated #{containers.length} containers"

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?