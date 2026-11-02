extends Node2D

var basicEnemy: PackedScene = preload("res://Enemies/basic_enemy.tscn")
var enemies: Array[Variant]

var enemyPath: Path2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("[INFO] EnemyFactory loaded")
	pass # Replace with function body.

func spawnBasicEnemy() -> void:
	var enemyInstance: Variant = basicEnemy.instantiate()
	enemies.push_back(enemyInstance)
	if !enemyPath: #no path? just return
		return
	enemyPath.add_child.call_deferred(enemyInstance)
	enemies.push_back(enemyInstance)
	pass
	
func getFistEnemyInRange(origin: Vector2, range: float) -> Variant:
	for enemy in enemies:
		var distance = origin.distance_to(enemy.global_position)
		if distance < 300:
			return enemy
	return null
	
func _input(event) -> void:
	if Input.is_action_just_pressed("spawn_enemy"):
		spawnBasicEnemy()
	pass
