extends Node2D

var enemy_array = []

func _physics_process(_delta: float) -> void:
	turn()
	
func turn():
	var enemy_positiont: Vector2 = get_global_mouse_position()
	look_at(enemy_positiont)
	
func _on_range_body_entered(body: Node2D) -> void:
	enemy_array.append(body.get_parent())
	print(enemy_array)


func _on_range_body_exited(body: Node2D) -> void:
	enemy_array.erase(body.get_parent())
