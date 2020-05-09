import { Controller } from "stimulus"

export default class extends Controller {
	connect() {
		this.endpoint = this.data.get("endpoint")
	}

	checkout(event) {
		fetch(this.endpoint)
		.then(response => response.json())
		.then((json) => {
			const stripe = Stripe('pk_test_Y2HGxcv4B58lA5tEakifsdiC00JK3c15ec');

			stripe.redirectToCheckout({
			  sessionId: json.session_id
			}).then(function (result) {
			  // Improve error logging
			  console.log(result.error.message)
			});
		})
	}
}
