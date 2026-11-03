extends Node

signal resources_changed(new_amount: int)
signal base_hp_changed(current_hp: int, max_hp: int)
signal game_over(has_won: bool)

@export var max_base_hp: int = 100
@export var initial_resources: int = 150

var current_base_hp: int
var current_resources: int
var is_game_over: bool = false

func _ready() -> void:
	reset_game()

func reset_game() -> void:
	is_game_over = false
	current_base_hp = max_base_hp
	current_resources = initial_resources
	
	resources_changed.emit(current_resources)
	base_hp_changed.emit(current_base_hp, max_base_hp)

func add_resources(amount: int) -> void:
	if is_game_over: return
	current_resources += amount
	resources_changed.emit(current_resources)

func try_spend_resources(amount: int) -> bool:
	if is_game_over or current_resources < amount:
		return false
	current_resources -= amount
	resources_changed.emit(current_resources)
	return true

func take_base_damage(amount: int) -> void:
	if is_game_over: return
	
	current_base_hp = max(0, current_base_hp - amount)
	base_hp_changed.emit(current_base_hp, max_base_hp)
	
	if current_base_hp <= 0:
		trigger_game_over(false)

func trigger_game_over(has_won: bool) -> void:
	if is_game_over: return
	is_game_over = true
	game_over.emit(has_won)

# --- STEROWANIE TESTOWE (KLAWIATURA) ---
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		add_resources(20)
	elif event.is_action_pressed("ui_down"):
		try_spend_resources(50)
	elif event.is_action_pressed("ui_accept"):
		take_base_damage(25)
