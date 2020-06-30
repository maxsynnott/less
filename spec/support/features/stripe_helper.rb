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

		def complete_authentication
			using_wait_time(10) do
				frame = find('body > div > iframe')

				within_frame(frame) do
					challenge_frame = find('#challengeFrame')

					within_frame(challenge_frame) do
						fullscreen_frame = find('.FullscreenFrame')

						within_frame(fullscreen_frame) do
							click_on "Complete authentication"
						end
					end
				end
			end
		end

		def fail_authentication
			using_wait_time(10) do
				frame = find('body > div > iframe')

				within_frame(frame) do
					challenge_frame = find('#challengeFrame')

					within_frame(challenge_frame) do
						fullscreen_frame = find('.FullscreenFrame')

						within_frame(fullscreen_frame) do
							click_on "Fail authentication"
						end
					end
				end
			end
		end
	end
end
