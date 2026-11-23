extends Node

var waves_config: Dictionary = {
	1: {"count": 5, "delay": 1.0},
	2: {"count": 10, "delay": 0.8},
	3: {"count": 15, "delay": 0.5}
}

var current_wave: int = 0
var enemies_left_to_spawn: int = 0
var spawn_timer: Timer

func _ready() -> void:
	spawn_timer = Timer.new()
	spawn_timer.one_shot = false
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(spawn_timer)
	
	await get_tree().create_timer(3.0).timeout
	start_next_wave()

func start_next_wave() -> void:
	current_wave += 1
	if not waves_config.has(current_wave):
		print("[INFO] Koniec fal!")
		return
		
	var wave_data = waves_config[current_wave]
	enemies_left_to_spawn = wave_data["count"]
	spawn_timer.wait_time = wave_data["delay"]
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	if enemies_left_to_spawn > 0:
		EnemyFactory.spawnBasicEnemy()
		enemies_left_to_spawn -= 1
	else:
		spawn_timer.stop()
		await get_tree().create_timer(10.0).timeout
		start_next_wave()
