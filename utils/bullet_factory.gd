extends Node

var bulletNode: PackedScene = preload("res://Towers/bullet/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("[INFO] BulletFactory loaded")


func spawnBullet(spawnPoint: Vector2) -> void:
	var bulletInstance: Variant = bulletNode.instantiate()
	add_child(bulletInstance)
	bulletInstance.set_position(spawnPoint)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
