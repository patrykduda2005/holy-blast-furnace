extends Node2D


func _physics_process(_delta: float) -> void:
	turn()
	
func turn():
	var enemy_positiont: Vector2 = get_global_mouse_position()
	var first_enemy: Variant = EnemyFactory.getFistEnemyInRange(self.global_position, 300.0)
	if first_enemy:
		enemy_positiont = first_enemy.global_position
	look_at(enemy_positiont)
