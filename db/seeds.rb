# DELETE THIS BEFORE REAL TIME PRODUCTION!
AdminUser.destroy_all
Delivery.destroy_all
CartItem.destroy_all
Cart.destroy_all
Order.destroy_all
User.destroy_all
########################################### IMPORTANT ######################################################################

AdminUser.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456') if Rails.env.development?

puts "Default Admin account created with: email: admin@example.com, password: 123456"

5.times do
	store = Store.create(
		name: Faker::Company.name,
		address: "Rudi-Dutschke-Straße 26 10969"
	)
end

num_items = 36

num_items.times do
	item = Item.create(
		name: Faker::Food.unique.ingredient,
		description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lobortis. " * rand(1..5),
		price: rand(0.001..0.1),
		tag_list: ["vegan", "organic"].sample([0, 1, 2].sample),
		store_ids: Store.all.sample(rand(0..Store.count)).map(&:id)
	)

	item.image.attach(io: File.open(Rails.root.join("app", "assets", "images", "glass_jar_#{rand(0..3)}.png")), filename: item.name.parameterize + '.png')
end

stock_items = Item.all.sample(num_items - 2)

stock_items.each { |item| Stock.create(item_id: item.id, balance: rand(2000..10000)) }

user = User.create(email: "user@example.com", password: "123456", cart: Cart.new)
user_2 = User.create(email: "user_2@example.com", password: "123456", cart: Cart.new)

puts "Default user account created with: email: user@example.com, password: 123456"

num_cart_items = rand(2..5)

cart_item_items = Item.all.sample(num_cart_items)

cart_item_items.each { |item| user.cart.add_item(item, rand(1..3000)) }

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

containers.each { |container| 100.times { Container.create(container) } }

puts "It has been done"
