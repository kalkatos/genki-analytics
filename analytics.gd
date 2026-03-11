## Main analytics entry point for the game. 
## Handles player ID persistence and routes events to the configured sender.
extends Node

@export var debug_mode: bool = false
@export var sender: AnalyticsSender

static var player_id: String


## Initial setup of player id and analytics mode
func _enter_tree () -> void:
	# Check if we should enable analytics based on editor state and debug mode
	if OS.has_feature("editor") and not debug_mode:
		print("Analytics module disabled in editor")
		return
	# Manage player ID: load existing or generate a new random one
	player_id = Storage.load("player_id", "")
	if player_id.is_empty():
		player_id = str(randi())
		Storage.save("player_id", player_id)
		print("Setup as player id: " + player_id)
	else:
		print("Loaded player id: " + player_id)


## Sends a simple event with the given key
func send_event (key: String):
	if _is_initialized():
		sender.send(key, "")


## Sends an event with a string value
func send_event_with_string (key: String, value: String):
	if _is_initialized():
		sender.send(key, value)


## Sends an event with a numeric value
func send_event_with_number (key: String, num: float):
	if _is_initialized():
		sender.send(key, num)


## Sends a unique event based on the given key
func send_unique_event (key: String, opt_value: Variant = null):
	if _is_initialized():
		sender.send_unique(key, opt_value, key)


## Sends a one-shot event that will only be sent once per player ID
func send_one_shot_event (key: String, opt_value: Variant = null):
	if not _is_initialized():
		return
	if Storage.has_value(key):
		return
	Storage.save(key, opt_value)
	sender.send(key, opt_value)


## Checks if the analytics module is initialized and ready to send events
func _is_initialized () -> bool:
	if OS.has_feature("editor") and not debug_mode:
		return false
	if sender and sender.is_initialized:
		return true
	push_warning("Analytics module is not initialized. Nothing will be sent")
	return false
