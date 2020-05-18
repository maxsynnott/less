puts "Let the seeding begin"

AdminUser.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456') if Rails.env.development?

puts "Default Admin account created with: email: admin@example.com, password: 123456"

num_products = 60

image_urls = [
	"https://www.fresh-square.com/wp-content/uploads/2016/10/Cherry-Tomato.jpg",
	"https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Patates.jpg/1200px-Patates.jpg",
	"https://images.squarespace-cdn.com/content/v1/5db8897cf38a0c72ea90a811/1574453264299-26RKZI4JJYNGIZAGENY7/ke17ZwdGBToddI8pDm48kLKHhjvX3gphN5FUFcFAex57gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UdeEXCY_GTEWd6VXxVNpiEK8h3-TrFakxXcdgG89kbU6tbi8Kdc17sDwJvAVtl8wPQ/Iroquois+All+Purpose+Flour+9859+copy.jpg",
	"https://i0.wp.com/images-prod.healthline.com/hlcmsresource/images/AN_images/health-benefits-of-eggs-1296x728-feature.jpg",
	"https://live.staticflickr.com/4201/34615573020_9337b7feb3_b.jpg",
	"https://sc01.alicdn.com/kf/UTB8SUNAl__IXKJkSalUq6yBzVXag.jpg"
]

num_products.times do
	product = Product.create(
		name: Faker::Food.unique.ingredient,
		description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer lobortis.",
		price: rand(0.001..0.1)
	)

	product.image.attach(io: open(image_urls.sample), filename: product.name.parameterize + '.jpg')
end

stock_products = Product.all.sample(num_products - 2)

stock_products.each { |product| Stock.create(product_id: product.id, balance: rand(500..10000)) }

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
