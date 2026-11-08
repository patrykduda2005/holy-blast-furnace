extends Node2D

const sight_range: float = 300.0
var type: TowerFactory.towerType = TowerFactory.towerType.fister

func _ready() -> void:
	Globals.bullet_timer.connect(_shoot)
	changeType(TowerFactory.towerType.walec) # temp
	
	
func changeType(type: TowerFactory.towerType):
	match type:
		TowerFactory.towerType.grabber:
			get_node("Sprite2D").texture = load("res://textures/grabber.png")
		TowerFactory.towerType.walec:
			get_node("Sprite2D").texture = load("res://textures/walec.png")
	self.type = type
			
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
		first_enemy.damage(10, self.type)

	
