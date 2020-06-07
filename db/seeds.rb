AdminUser.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456') if Rails.env.development?

puts "Default Admin account created with: email: admin@example.com, password: 123456"

image_urls = [
	"https://www.benjerry.com/files/live/sites/systemsite/files/flavors/products/us/pint/phish-food-detail-open-2019.png",
	"https://png2.cleanpng.com/sh/18fe59802636e449d2fda21502acce22/L0KzQYm3WMI1N5l8epH0aYP2gLBuTgRiap1qj9N7ZT3wccT2jr1raaMyf95qc4Owc7L3gfNqfJJze9c2cHB1c7bzgflvNWIyTZ8AYkizQIHrhMRmQGFmSJC9OEW2Roe7WcE2O2Y2Sac9OEW2QoK9TwBvbz==/kisspng-tableware-mason-jar-glass-capacitance-porcelain-1-5-5b8000dd4e80a0.4853664915351154853216.png",
	"https://i.pinimg.com/originals/0f/90/c1/0f90c1a847cb971519b96c6a1098f375.png",
	"https://s3.amazonaws.com/greengiant-us/wp-content/uploads/2019/02/11224329/800x800_Green-Giant-Whole-Mushrooms-6-oz.-Jar.png",
	"https://www.puremarket.com/wp-content/uploads/2019/10/earths-best-stage-3-organic-vegetable-chicken-soup-na-jars-meals.png?w=350"
]

store_logo_urls = [
	"https://cdn.shopify.com/s/files/1/1008/4236/files/01Original_Unverpackt_Logo_nichtoffen_160712_Kopie.jpg",
	"https://www.designenlassen.de/blog/wp-content/uploads/2018/09/%C3%B6ko-logo-bio-h%C3%BCllenlos-unverpackt-nachhaltig.png",
	"https://cdn.shopify.com/s/files/1/0279/6440/7901/files/unverpackt_trier_logo_komplett_1000x1000.png",
	"https://www.supertipp-online.de/wp-content/uploads/2019/05/Unverpackt-RA.jpg"
]

num_products = 8

store_logo_urls.each do |url|
	store = Store.create(
		name: Faker::Company.name,
		address: Address.create(line_1: "Rudi-Dutschke-Straße 26", postal_code: "10969", country: "DE")
	)

	store.image.attach(io: open(url), filename: store.name.parameterize + '.jpg')

	num_products.times do
		product = Product.create(
			name: Faker::Food.unique.ingredient,
			description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lobortis.",
			price: rand(0.001..0.1),
			tag_list: ["vegan", "organic"].sample([0, 1, 2].sample),
			store_id: store.id
		)

		product.image.attach(io: open(image_urls.sample), filename: product.name.parameterize + '.jpg')
	end
end

user = User.create(email: "user@example.com", password: "123456", cart: Cart.new)
user_2 = User.create(email: "user_2@example.com", password: "123456", cart: Cart.new)

puts "Default user account created with: email: user@example.com, password: 123456"

num_cart_items = rand(2..5)

cart_item_products = Product.all.sample(num_cart_items)

cart_item_products.each { |product| user.cart.add_product(product, rand(1..3000)) }

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

containers.each { |container| 5.times { Container.create(container) } }

puts "It has been done"
