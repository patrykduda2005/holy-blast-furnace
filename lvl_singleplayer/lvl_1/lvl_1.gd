extends Node2D

@onready var escape_menu: Control = $Camera2D/EscapeMenu
@onready var hp_label: Label = $HUD/HpLabel
var paused: bool = false

func _ready() -> void:
	_on_player_hp_changed(Globals.player_hp, Globals.max_player_hp)
	Globals.player_hp_changed.connect(_on_player_hp_changed)
	Globals.player_died.connect(_on_player_died)

func _on_player_hp_changed(current_hp: float, max_hp: float) -> void:
	if hp_label:
		hp_label.text = "HP Pieca: %d / %d" % [int(current_hp), int(max_hp)]

func _on_player_died() -> void:
	if hp_label:
		hp_label.text = "HP Pieca: 0 / %d - PIEC ZNISZCZONY!" % int(Globals.max_player_hp)
	get_tree().paused = true
