class_name AnalyticsSender
extends Node
## Base class for analytics sender implementations.
## Provides the interface for sending events and handles basic initialization.

var is_initialized: bool


## Called when the node enters the scene tree
func _ready () -> void:
	initialize()


## Initializes the sender
func initialize ():
	is_initialized = true


## Sends an event with the given key and value
func send (key: String, value: Variant):
	print("Sending (FAKE) event: %s with value %s" % [key, str(value)])


## Sends a unique event based on the given key, value, and ID
func send_unique (key: String, value: Variant, id: String):
	print("Sending (FAKE) unique event: %s with value %s and id %s" % [key, str(value), id])
