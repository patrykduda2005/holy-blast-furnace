extends Node

signal bullet_timer

var timer: Timer
var menu_on: bool = true

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = 1.0      # Set interval to 1 second
	timer.one_shot = false     # Make it loop continuously
	timer.autostart = true     # Start automatically when the game loads
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout() -> void:
	bullet_timer.emit()
