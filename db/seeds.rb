# DELETE THIS BEFORE REAL TIME PRODUCTION!
Delivery.destroy_all
CartItem.destroy_all
Cart.destroy_all
Order.destroy_all
User.destroy_all
########################################### IMPORTANT ######################################################################

User.create!(first_name: "Max", email: 'admin@example.com', password: '123456', password_confirmation: '123456', role: 2, cart: Cart.new) if Rails.env.development?

puts "Default Admin account created with: email: admin@example.com, password: 123456"

item_attributes = [
	{
		name: "Flour",
		description: "Whole wheat flour",
		price: 0.00095,
		tag_list: ["Grains"],
		units: ["gram", "cup"]
	},
	{
		name: "Eggs",
		description: "Free range eggs",
		price: 0.33,
		tag_list: [],
		display_unit: "egg",
		display_price_quantity: 1,
		units: ["egg"]
	},
	{
		name: "Salt",
		description: "Himalayan rock salt",
		price: 0.0099,
		tag_list: [],
		display_unit: "tablespoon",
		display_price_quantity: 17.07,
		units: ["gram", "tablespoon"]
	}
]

item_attributes.each do |attributes|
	item = Item.create(attributes)

	images = [0, 1, 2, 3].sample(rand(1..4)).map { |i| { io: File.open(Rails.root.join("app", "assets", "images", "glass_jar_#{i}.png")), filename: "jar_#{i}.png" } }

	item.main_image.attach(images.delete_at(0))
	item.images.attach(images)
end

stock_items = Item.all.sample(item_attributes.length - 2)

stock_items.each { |item| Stock.create(item_id: item.id, balance: rand(2000..10000)) }

user = User.create(first_name: "Max", email: "user@example.com", password: "123456", cart: Cart.new)
user_2 = User.create(first_name: "Max", email: "user_2@example.com", password: "123456", cart: Cart.new)

puts "Default user account created with: email: user@example.com, password: 123456"

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
