## Example script demonstrating how to use the Analytics module by listening to signal events.
extends Node


func _ready () -> void:
	## Connect to signals here
	pass


## Handles the event example; replace with actual event handling logic
func _handle_event_example ():
	Analytics.send_event("event_name")
