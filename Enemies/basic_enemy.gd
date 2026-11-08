extends PathFollow2D

@export var run_speed: int = 50

# Wlasciwosci przeciwnika, od tych zmiennych zalezy dzialanie wiezyczek
var durability: float = -1
var hardness: float = -1
var plasticity: float = -1

var isStunned: bool = false

var hp = 100

func _ready() -> void:
	# Wyłącza zapętlanie ścieżki, aby wróg nie wracał na start po dotarciu do pieca
	loop = false


func _process(delta: float) -> void:
	
	progress += run_speed * delta
	if hp <= 0:
		die()
	
func die() -> void:
	# miejsce na animacje czy cos
	EnemyFactory.plsKill(self)

func setProperties(durability, hardness, plasticity):
	assert(durability >= 0)
	assert(hardness >= 0)
	assert(plasticity >= 0)
	self.durability = durability
	self.hardness = hardness
	self.plasticity = plasticity
	
func damage(damage: int, tower_type: TowerFactory.towerType):
	match tower_type:
		TowerFactory.towerType.grabber:
			self.hp -= 10/(10 + self.durability) * damage
			var temp_speed = self.run_speed
			self.run_speed = 0
			self.isStunned = true
			await get_tree().create_timer(clamp(5/(5 + self.durability) * 1, 0.01, 0.99)).timeout
			self.run_speed = temp_speed
			self.isStunned = false
		TowerFactory.towerType.walec:
			self.hp -= 10/(10 + self.plasticity) * damage
			self.run_speed -= 5/(5 + self.plasticity) * 20
			if self.run_speed <= Globals.minimal_enemy_speed:
				self.run_speed = Globals.minimal_enemy_speed
			if self.run_speed == 0: # no, stopping pls
				self.run_speed = -5
		TowerFactory.towerType.fister:
			self.hp -= 10/(10 + self.hardness) * damage
		_:
			return

#	if progress_ratio >= 1.0:
#		# Tutaj dodajcie zadanie obrażeń bazie, np. GameManager.damage_base(10)
#		queue_free()
