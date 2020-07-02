# DELETE THIS BEFORE REAL TIME PRODUCTION!
Delivery.destroy_all
CartItem.destroy_all
Cart.destroy_all
Order.destroy_all
User.destroy_all
Item.destroy_all
########################################### IMPORTANT ######################################################################

User.create!(first_name: "Max", email: 'admin@example.com', password: '123456', password_confirmation: '123456', role: 2, cart: Cart.new) if Rails.env.development?

puts "Default Admin account created with: email: admin@example.com, password: 123456"

# Flour
# Eggs
# Salt
# Chocolate Muesli
# Pasta
# Sternburg
# Sternburg Crate
# Oats Milk
# Rice
# Red Lentils

items = [
	{
		attributes: {
			name: "Flour",
			description: "Whole wheat flour",
			price: 0.00095,
			tag_list: ["Grains"],
			display_quantity: 100,
			units: [
				Unit.new(name: 'gram', base_units: 1, default: true),
				Unit.new(name: 'kg', base_units: 1000),
				Unit.new(name: 'cup', base_units: 120)
			]
		},
		images: [
			"https://www.goldenacrewines.co.uk/wp-content/uploads/2020/04/eee.png",
			"https://i.pinimg.com/originals/29/17/61/29176176610a7b70a659e84d107bdd16.png",
			"https://www.floursackstudio.com/wp-content/uploads/2016/02/custom-flour-sack-small.png"
		]
	},
	{
		attributes: {
			name: "Eggs",
			description: "Free range eggs",
			price: 0.33,
			tag_list: [],
			units: [
				Unit.new(name: 'egg', base_units: 1, default: true),
				Unit.new(name: 'dozen', base_units: 12)
			]
		},
		images: [
			"https://a591xot9423uvz1c41kdg5yq-wpengine.netdna-ssl.com/wp-content/uploads/2017/10/eggs-rotated.png",
			"https://cspinet.org/sites/default/files/styles/large/public/egg_PNG40784.png?itok=pXQgfFgI"
		]
	},
	{
		attributes: {
			name: "Salt",
			description: "Himalayan rock salt",
			price: 0.0099,
			tag_list: [],
			units: [
				Unit.new(name: 'gram', base_units: 1),
				Unit.new(name: 'tablespoon', base_units: 17, default: true)
			]
		},
		images: [
			"https://natural-gas.centre.uq.edu.au/files/7478/salt%20-%20creative%20commons.png"
		]
	},
	{
		attributes: {
			name: "Chocolate Muesli",
			description: "Muesli with chunky chocolate pieces",
			price: 0.0033,
			tag_list: [],
			units: [
				Unit.new(name: 'gram', base_units: 1),
				Unit.new(name: 'bowl', base_units: 250),
				Unit.new(name: 'kg', base_units: 1000, default: true)
			]
		},
		images: [
			"https://naturesfarm.ca/wp-content/uploads/2020/03/granola-chocolate-chunk-2.png"
		]
	},
	{
		attributes: {
			name: "Pasta",
			description: "Organic whole grain Penne",
			price: 0.003,
			tag_list: [],
			units: [
				Unit.new(name: 'gram', base_units: 1),
				Unit.new(name: 'kg', base_units: 1000, default: true)
			]
		},
		images: [
			"https://www.pngkit.com/png/full/935-9351800_penne-pasta-penne-pasta-png.png",
			"https://lh3.googleusercontent.com/proxy/typtjhdaLKKIjofYqP5dWVJsvmDhd72IQu20Y6T_pPCQK5TnPRczpb45odGCRKRKUNdSBwecmR7EFuG8bGedaoRmpgLMILfNW6GvbBSFzTmsnySE3SUdCe4ytP3QAa7_g8CpMhSAcg"
		]
	},
	{
		attributes: {
			name: "Sternburg",
			description: "The classic 0.5L",
			price: 0.6,
			tag_list: [],
			units: [
				Unit.new(name: 'bottle', base_units: 1, default: true)
			]
		},
		images: [
			"https://img.rewe-static.de/8484490/1245680_digital-image.png"
		]
	},
	{
		attributes: {
			name: "Sternburg Crate (20x0.5)",
			description: "20x The classic 0.5L with crate",
			price: 12,
			tag_list: [],
			units: [
				Unit.new(name: 'crate', base_units: 1, default: true)
			]
		},
		images: [
			"https://www.magdeburg-liefert.de/images/product_images/original_images/1420470_digital-image.png"
		]
	},
	{
		attributes: {
			name: "Oats Milk",
			description: "Hafer good day",
			price: 0.001,
			tag_list: [],
			units: [
				Unit.new(name: 'ml', base_units: 1),
				Unit.new(name: 'litre', base_units: 1000, default: true)
			]
		},
		images: [
			"https://img.rewe-static.de/2587736/24675765_digital-image.png"
		]
	},
	{
		attributes: {
			name: "Rice",
			description: "It's a rice to the top",
			price: 0.003,
			tag_list: [],
			units: [
				Unit.new(name: 'gram', base_units: 1),
				Unit.new(name: 'kg', base_units: 1000, default: true)
			]
		},
		images: [
			"https://images.squarespace-cdn.com/content/v1/58b72eac46c3c480fcbe7366/1551906370876-2QFYXGTV60734RJA74NX/ke17ZwdGBToddI8pDm48kHxmscvA7sPLr44hRr9b6YhZw-zPPgdn4jUwVcJE1ZvWhcwhEtWJXoshNdA9f1qD7aP-VOPYnKXVfGNi7anTLYFfR8iOka_FOcdiOTfz5L3AoLt7g31T-kqs2xaOSHFQFw/Risotto.png",
			"https://cdn.shopify.com/s/files/1/0012/1657/7656/products/rice-cup_1200x1200.png?v=1583401953"
		]
	},
	{
		attributes: {
			name: "Red Lentils",
			description: "Organic red lentils",
			price: 0.0035,
			tag_list: [],
			units: [
				Unit.new(name: 'gram', base_units: 1),
				Unit.new(name: 'kg', base_units: 1000, default: true)
			]
		},
		images: [
			"https://sc01.alicdn.com/kf/HTB1GQEqKFXXXXapXVXXq6xXFXXXE.jpg",
			"https://i.ya-webdesign.com/images/beans-vector-lentils-10.png"
		]
	}
]

items.each do |item|
	images = item[:images].map.with_index { |image, i| { io: open(image), filename: "#image_#{i}.png" } }

	item = Item.create(item[:attributes])

	item.main_image.attach(images.delete_at(0))
	item.images.attach(images)
end

stock_items = Item.all.sample(Item.count - 2)

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
