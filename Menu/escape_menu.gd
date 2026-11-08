extends Control

@onready var quit: Button = $MarginContainer/VBoxContainer/Quit
@onready var exit_to_menu: Button = $MarginContainer/VBoxContainer/ExitToMenu
@onready var resume: Button = $MarginContainer/VBoxContainer/Resume

#var escape_menu: Control
var paused: bool = false 

func _ready() -> void:
	exit_to_menu.pressed.connect(_on_exit_to_menu_pressed)
	quit.pressed.connect(_on_quit_pressed)
	resume.pressed.connect(_on_resume_pressed)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("EscapeMenu"):
		_escapeMenu()
	pass

func _on_resume_pressed() -> void:
	_escapeMenu()

func _on_exit_to_menu_pressed() -> void:
	Globals.menu_on = true
	get_tree().change_scene_to_file("res://Menu/Menu.tscn")

func _on_quit_pressed() -> void:
	print("Nara frajerze")
	get_tree().quit()

func _escapeMenu() -> void:
	if paused:
		Globals.menu_on = false
		self.hide()
		Engine.time_scale = 1
	else:
		Globals.menu_on = true
		self.show()
		Engine.time_scale = 0
	
	paused = !paused
