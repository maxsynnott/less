puts "Let the seeding begin"

AdminUser.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456') if Rails.env.development?

puts "Default Admin account created with: email: admin@example.com, password: 123456"

num_products = 10

num_products.times do
	Product.create(
		name: Faker::Food.unique.ingredient,
		description: Faker::Food.description,
		price: rand(0.001..0.1)
	)
end

user = User.create(email: "user@example.com", password: "123456", cart: Cart.new)

puts "Default user account created with: email: user@example.com, password: 123456"

num_orders = rand(2..5)

products = Product.all.sample(num_orders)

products.each { |product| user.cart.add_product(product, rand(1..3000)) }

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

5.times do
	recipe = Recipe.create(
		public: true,
		name: Faker::Food.dish,
		description: Faker::Food.description
	)

	Product.all.sample(3).each do |product|
		RecipeItem.create(
			product_id: product.id,
			recipe_id: recipe.id,
			quantity: rand(100..500)
		)
	end
end


puts "It has been done"
