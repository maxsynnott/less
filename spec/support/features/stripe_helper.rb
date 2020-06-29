module Features
	module StripeHelper
		def fill_stripe_elements(card = {})
			defaults = {
				number: "4242424242424242",
				expiry: "1234",
				cvc: "123",
				postal: "11111"
			}

			card = defaults.merge(card)

		  using_wait_time(10) do
		    frame = find('#card-element > div > iframe')

		    within_frame(frame) do
			    card[:number].to_s.chars.each { |piece|find_field('cardnumber').send_keys(piece) }

			    find_field('exp-date').send_keys card[:expiry]
			    find_field('cvc').send_keys card[:cvc]
			    find_field('postal').send_keys card[:postal]
			  end
			end
		end
	end
end
