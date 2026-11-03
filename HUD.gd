extends Control

@onready var resources_label: Label = $ResourcesLabel
@onready var hp_bar: ProgressBar = $HPBar
@onready var start_wave_button: Button = $StartWaveButton

@export var wave_manager: Node

func _ready() -> void:
	GameManager.resources_changed.connect(_update_resources)
	GameManager.base_hp_changed.connect(_update_hp)
	
	_update_resources(GameManager.current_resources)
	_update_hp(GameManager.current_base_hp, GameManager.max_base_hp)
	
	if start_wave_button:
		start_wave_button.pressed.connect(_on_start_btn_pressed)

func _update_resources(amount: int) -> void:
	if resources_label:
		resources_label.text = "Surowce: %d" % amount

func _update_hp(current: int, maximum: int) -> void:
	if hp_bar:
		hp_bar.max_value = maximum
		hp_bar.value = current

func _on_start_btn_pressed() -> void:
	if wave_manager and wave_manager.has_method("start_next_wave"):
		wave_manager.start_next_wave()
		start_wave_button.disabled = true
