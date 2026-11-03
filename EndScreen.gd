extends Control

@onready var title_label: Label = $CenterContainer/VBoxContainer/TitleLabel
@onready var restart_button: Button = $CenterContainer/VBoxContainer/RestartButton

func _ready() -> void:
	hide()
	GameManager.game_over.connect(_show_screen)
	
	if restart_button:
		restart_button.pressed.connect(_restart_game)

func _show_screen(has_won: bool) -> void:
	show()
	if not title_label: return
	
	if has_won:
		title_label.text = "ZWYCIĘSTWO"
		title_label.modulate = Color.GREEN
	else:
		title_label.text = "PORAŻKA"
		title_label.modulate = Color.RED

func _restart_game() -> void:
	GameManager.reset_game()
	get_tree().reload_current_scene()
