AdminUser.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456') if Rails.env.development?

puts "Default Admin account created with: email: admin@example.com, password: 123456"

image_urls = [
	"https://www.benjerry.com/files/live/sites/systemsite/files/flavors/items/us/pint/phish-food-detail-open-2019.png",
	"https://i.pinimg.com/originals/0f/90/c1/0f90c1a847cb971519b96c6a1098f375.png",
	"https://www.puremarket.com/wp-content/uploads/2019/10/earths-best-stage-3-organic-vegetable-chicken-soup-na-jars-meals.png?w=350",
	"https://www.whi.de/fileadmin/user_upload/Wuensche_Food/ProduktbereicheKacheln/tomate.png",
	"https://www.whi.de/fileadmin/user_upload/Wuensche_Food/ProduktbereicheKacheln/ananas.png"
]

store_logo_urls = [
	"https://cdn.shopify.com/s/files/1/1008/4236/files/01Original_Unverpackt_Logo_nichtoffen_160712_Kopie.jpg",
	"https://www.designenlassen.de/blog/wp-content/uploads/2018/09/%C3%B6ko-logo-bio-h%C3%BCllenlos-unverpackt-nachhaltig.png",
	"https://cdn.shopify.com/s/files/1/0279/6440/7901/files/unverpackt_trier_logo_komplett_1000x1000.png",
	"https://www.supertipp-online.de/wp-content/uploads/2019/05/Unverpackt-RA.jpg"
]

store_logo_urls.each do |url|
	store = Store.create(
		name: Faker::Company.name,
		address: "Rudi-Dutschke-Straße 26 10969"
	)

	store.image.attach(io: open(url), filename: store.name.parameterize + '.jpg')
end

num_items = 36

num_items.times do
	item = Item.create(
		name: Faker::Food.unique.ingredient,
		description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lobortis.",
		price: rand(0.001..0.1),
		tag_list: ["vegan", "organic"].sample([0, 1, 2].sample),
		store_ids: Store.all.sample(rand(0..Store.count)).map(&:id)
	)

	item.image.attach(io: open(image_urls.sample), filename: item.name.parameterize + '.jpg')
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
