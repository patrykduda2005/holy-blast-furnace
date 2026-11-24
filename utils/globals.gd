extends Node

signal bullet_timer
signal player_hp_changed(current_hp: float, max_hp: float)
signal player_died

var timer: Timer
var menu_on: bool = true
var minimal_enemy_speed: int = -20

var player_hp: float = 500.0
var max_player_hp: float = 500.0

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = 1.0      
	timer.one_shot = false     
	timer.autostart = true     
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout() -> void:
	bullet_timer.emit()

func update_player_hp(current_hp: float, max_hp: float) -> void:
	player_hp = current_hp
	max_player_hp = max_hp
	player_hp_changed.emit(player_hp, max_player_hp)
	if player_hp <= 0.0:
		player_died.emit()
