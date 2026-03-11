class_name HttpSender
## Generic HTTP sender for analytics events. 
## Sends data as JSON via POST requests to the specified URL.
extends AnalyticsSender

var url: String = "https://myanalyticsserver.com/submit_event"
var headers: Array[String] = ["Content-Type: application/json"]


## Sends an event with the given key and value via HTTP POST
func send (key: String, value: Variant) -> void:
	# Prepare event payload
	var data = {
		"PlayerId": Analytics.player_id,
		"Key": key,
		"Value": value,
	}
	# Setup and fire HTTPRequest
	var request = HTTPRequest.new()
	add_child(request)
	request.request(url, headers, HTTPClient.METHOD_POST, JSON.stringify(data))
	# Cleanup request node after completion
	request.request_completed.connect(func (_x, _y, _z, _w): request.queue_free())
	print("Sending event: %s with value %s" % [key, str(value)])


## Sends a unique event based on the given key, value, and ID via HTTP POST
func send_unique (key: String, value: Variant, id: String) -> void:
	# Prepare event payload with partition key
	var data = {
		"PlayerId": Analytics.player_id,
		"Key": key,
		"Value": value,
		"ForcePartitionKey": id,
	}
	# Setup and fire HTTPRequest
	var request = HTTPRequest.new()
	add_child(request)
	request.request(url, headers, HTTPClient.METHOD_POST, JSON.stringify(data))
	# Cleanup request node after completion
	request.request_completed.connect(func (_x, _y, _z, _w): request.queue_free())
	print("Sending event: %s with value %s and id %s" % [key, str(value), id])
