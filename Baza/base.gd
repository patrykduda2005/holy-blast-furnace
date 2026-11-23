extends StaticBody2D

signal healthChanged(current_hp: float, max_hp: float)


var max_hp:float = 500.0
var hp: float = 500.0:
	set(new_value):
		hp = clamp(new_value, 0.0, max_hp)
		healthChanged.emit(hp, max_hp)

@onready var health_bar: TextureProgressBar = $HealthBar/tower_health_bar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	healthChanged.connect(health_bar.set_health_bar)
	health_bar.set_health_bar(hp, max_hp)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
