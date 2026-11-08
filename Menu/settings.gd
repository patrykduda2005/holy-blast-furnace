extends Control

@onready var window_btn: MenuButton = $VBoxContainer/Window
@onready var resolution_btn: MenuButton = $VBoxContainer/Resolution
@onready var save_btn: Button = $"../SaveSettingsButton"

var selected_window: String = "Windowed"
var selected_resolution: String = "1920x1080"


func _ready() -> void:
	# 1. Dodajemy opcje do MenuButton (Window)
	var win_popup: PopupMenu = window_btn.get_popup()
	win_popup.clear()
	win_popup.add_item("Windowed")
	win_popup.add_item("Fullscreen")
	win_popup.id_pressed.connect(_on_window_selected)

	# 2. Dodajemy opcje do MenuButton (Resolution)
	var res_popup: PopupMenu = resolution_btn.get_popup()
	res_popup.clear()
	res_popup.add_item("1280x720")
	res_popup.add_item("1600x900")
	res_popup.add_item("1920x1080")
	res_popup.id_pressed.connect(_on_resolution_selected)

	# 3. Wczytujemy zapisane wartości z bazy SQLite
	var current_data: Dictionary = SqLiteManager.load_settings()
	selected_window = current_data["window_mode"]
	selected_resolution = current_data["resolution"]

	window_btn.text = "Screen: " + selected_window
	resolution_btn.text = "Resolution: " + selected_resolution

	# 4. Podpinamy przycisk SaveSettingsButton
	save_btn.pressed.connect(_on_save_settings_button_pressed)


func _on_window_selected(id: int) -> void:
	selected_window = window_btn.get_popup().get_item_text(id)
	window_btn.text = "Screen: " + selected_window


func _on_resolution_selected(id: int) -> void:
	selected_resolution = resolution_btn.get_popup().get_item_text(id)
	resolution_btn.text = "Resolution: " + selected_resolution


func _on_save_settings_button_pressed() -> void:
	SqLiteManager.save_settings(selected_window, selected_resolution)
