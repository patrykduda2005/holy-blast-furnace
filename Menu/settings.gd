extends Control

const settings_path: String = "res://Menu/Settings/settings.save"

signal settings_changed

var settings = {
	&"V-Sync": true,
	&"Resolution": "1920x1080p"
}

var resolution_btn: MenuButton
var screen_btn: MenuButton

func _ready() -> void:
	load_settings()
	
	resolution_btn = $"VBoxContainer/MenuButton"
	resolution_btn.get_popup().id_pressed.connect(_on_resolution_btn_pressed)
	
	resolution_btn = $"VBoxContainer/MenuButton2"
	#screen_btn.get_popup().id_pressed.connect(_on_screen_btn_pressed)

func _on_resolution_btn_pressed(id: int) -> void:
	#var resolution_arr: Array[String] = ["1920x1080p", "800x600p"]
	match(id):
		0:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
		1:
			#get_tree().root.size = Vector2i(800, 600)
			DisplayServer.window_set_size(Vector2i(1920, 1080))
	pass

func _on_screen_btn_pressed(id: int) -> void:
	match(id):
		0:
			#get_window().mode = Window.MODE_FULLSCREEN
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1:
			get_window().mode = Window.MODE_WINDOWED
		2:
			get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
	pass

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
		print("Jest :D")
		var file = FileAccess.open(settings_path, FileAccess.READ)
		var result: Variant = JSON.parse_string(file.get_as_text())
		
		if result is Dictionary:
			settings = result
		file.close()
	else:
		print("Nie ma :D")
		#JSON.
