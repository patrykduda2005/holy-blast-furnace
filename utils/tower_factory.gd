extends Node

var touretNode: PackedScene = preload("res://Towers/touret.tscn")
var towersNode: Node2D

enum towerType {
	grabber,
	walec,
	fister,
}

func _ready() -> void:
	print("[INFO] TowerFactory loaded")


func spawnTower(spawnPoint: Vector2) -> void:
	var touretInstance: Variant = touretNode.instantiate()
#	towersNode.add_child.call_deferred(touretInstance)
	touretInstance.set_position(spawnPoint)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
