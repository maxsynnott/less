import consumer from "./consumer"

// Move this into a stimulus controller
consumer.subscriptions.create(
	{
		channel: "DeliveryTrackerChannel", 
		delivery_id: 1 // window.location.href.match(/deliveries\/(\d+)\/tracker/)[1]
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
