class_name FunctionsSender
## A specialized HttpSender that loads its destination URL from a configuration file.
extends HttpSender

const URLS_FILE_PATH: String = "res://Game/Settings/urls.json"


## Loads URLs from the settings file and initializes the sender
func _ready () -> void:
	# Attempt to read URL from the local JSON config file
	if FileAccess.file_exists(URLS_FILE_PATH):
		var file := FileAccess.open(URLS_FILE_PATH, FileAccess.READ)
		var json := JSON.parse_string(file.get_as_text())
		if json and json.has("SendEvent"):
			url = json["SendEvent"]
			initialize()
			return
	Debug.log_warning("URLs file not found or invalid, using default URL")
	