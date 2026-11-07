extends Control

const settings_path: String = "res://Menu/Settings/settings.save"

signal settings_changed

var settings = {
	&"V-Sync": true
}

func _ready() -> void:
	load_settings()

func upadate_settings(settings_name: StringName, value: float) -> void:
	settings[settings_name] = value
	settings_changed.emit()
	save_settings()

func get_setting(setting_name: StringName) -> Variant:
	return settings[setting_name]

func save_settings() ->void:
	var file = FileAccess.open(settings_path, FileAccess.WRITE)
	if file != null:
		file.store_string(JSON.stringify(settings, "\t"))
		file.close()
		

func load_settings() -> void:
	if FileAccess.file_exists(settings_path):
		var file = FileAccess.open(settings_path, FileAccess.READ)
		var result: Variant = JSON.parse_string(file.get_as_text())
		
		if result is Dictionary:
			settings = result
		file.close()
