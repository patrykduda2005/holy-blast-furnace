extends PathFollow2D

@export var run_speed: int = 50

var hp = 100

func _ready() -> void:
	# Wyłącza zapętlanie ścieżki, aby wróg nie wracał na start po dotarciu do pieca
	loop = false


func _process(delta: float) -> void:
	progress += run_speed * delta
	if hp <= 0:
		die()
	
func die() -> void:
	EnemyFactory.plsKill(self)

#	if progress_ratio >= 1.0:
#		# Tutaj dodajcie zadanie obrażeń bazie, np. GameManager.damage_base(10)
#		queue_free()
