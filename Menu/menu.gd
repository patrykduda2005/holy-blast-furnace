extends Control

var single_menu: Control
var singleplayer_btn: Button
var settings_menu: Control
var settings_btn: Button
var exit_btn: Button

func _ready() -> void:
	#zmienne
	single_menu = $"Singleplayer layout"
	singleplayer_btn = $"Main menu layout/VBoxContainer/Singleplayer"
	single_menu.visible = false
	settings_menu = $"Settings layout"
	settings_btn = $"Main menu layout/VboxContainer/Settings"
	settings_menu.visible = false
	exit_btn = $"Main menu layout/VBoxContainer/Exit"
	
	
	#akcja	
	singleplayer_btn.pressed.connect(_on_singleplayer_pressed)
	settings_btn.pressed.connect(_on_settings_button_pressed)
	exit_btn.pressed.connect(_on_exit_pressed)
	
	for button: Button in $"Singleplayer layout/GridContainer".get_children():
		button.pressed.connect(_on_level_button_pressed.bind(button.name))

#Singleplayer
func _on_singleplayer_pressed() -> void:
	single_menu.visible = !single_menu.visible
	print("Singleplayer button pressed\n")

#Wybór poziomu singleplayer
func _on_level_button_pressed(level_name: String) -> void:
	var scene_path: String = "res://lvl_singleplayer/%s/%s.tscn" % [level_name, level_name]
	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
	else:
		print("Scena jeszcze nie istnieje: ", scene_path)

#Ustawienia
func _on_settings_button_pressed() -> void:
	settings_menu.visible = !settings_menu.visible
	print("Settings button pressed\n")
	

#Wyjście z gry
func _on_exit_pressed() -> void:
	print("Exit button pressed\n")
	get_tree().quit()


func _process(delta: float) -> void:
	pass
