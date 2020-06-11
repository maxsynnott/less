import consumer from "./consumer"

consumer.subscriptions.create(
	{
		channel: "DeliveryTrackerChannel", 
		delivery_id: window.location.href.match(/deliveries\/(\d+)\/tracker/)[1]
	},
	{
	  connected() {
	    // Called when the subscription is ready for use on the server
	    console.log("Connected")
	  },

	  disconnected() {
	    // Called when the subscription has been terminated by the server
	  },

	  received(data) {
	  	$("#status_span").text(data.status)
	  }
	}
);
