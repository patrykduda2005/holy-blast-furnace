extends Node2D

func _physics_process(_delta: float) -> void:
	turn()
	
func turn():
	var enemy_positiont: Vector2 = get_global_mouse_position()
	look_at(enemy_positiont)
