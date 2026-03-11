## Example script demonstrating how to use the Analytics module by listening to signal events.
extends Node

## Connects to initial signals
func _ready () -> void:
	## Connect to signal here
	# SignalBus._on_settings_panel.connect(_handle_settings_panel)
	pass


## Handles the settings panel visibility change and sends an analytics event
func _handle_settings_panel (open: bool):
	## Send event only when the panel is opened
	if (open):
		Analytics.send_event("settings_opened")
