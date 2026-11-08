extends Node2D

var basicEnemy: PackedScene = preload("res://Enemies/basic_enemy.tscn")
var enemies: Array[Variant]

var enemyPath: Path2D # EnemyPath przy zaladowaniu poziomu musi sie tutaj wczytac

func _ready() -> void:
	print("[INFO] EnemyFactory loaded")


func spawnBasicEnemy() -> void:
	if !enemyPath: #no path? just return
		return
	var enemyInstance: Variant = basicEnemy.instantiate()
	#							dur, har, plast
	enemyInstance.setProperties(15, 100, 20)
	enemies.push_back(enemyInstance)
	enemyPath.add_child.call_deferred(enemyInstance)
	
func getFistEnemyInRange(origin: Vector2, range: float) -> Variant:
	for enemy in enemies:
		var distance = origin.distance_to(enemy.global_position)
		if distance < 300:
			return enemy
	return null
	
func plsKill(victim: Variant) -> void:
	for enemyIndex in range(enemies.size()):
		if enemies.get(enemyIndex) == victim:
			enemies.remove_at(enemyIndex)
			victim.call_deferred("free")
	
func _input(event) -> void:
	if Input.is_action_just_pressed("spawn_enemy"):
		spawnBasicEnemy()
	if Input.is_action_just_pressed("towered"):
		TowerFactory.spawnTower(get_global_mouse_position())

func reset() -> void:
	for enemy in enemies:
		if is_instance_valid(enemy):
			enemy.free()
	enemies.clear()
	enemyPath = null
