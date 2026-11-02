extends Node2D

const sight_range: float = 300.0

func _ready() -> void:
	Globals.bullet_timer.connect(_shoot)
	BulletFactory.spawnBullet(Vector2(200, 200))

	
	
func _physics_process(_delta: float) -> void:
	turn()
	
func turn():
	var enemy_positiont: Vector2 = get_global_mouse_position()
	var first_enemy: Variant = EnemyFactory.getFistEnemyInRange(self.global_position, sight_range)
	if first_enemy:
		enemy_positiont = first_enemy.global_position
	look_at(enemy_positiont)
	
func _shoot():
	var first_enemy = EnemyFactory.getFistEnemyInRange(self.global_position, sight_range)
	if first_enemy:
		first_enemy.hp -= 10

	
