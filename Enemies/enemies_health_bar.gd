extends TextureProgressBar

func set_health_bar(current_hp: float, max_hp: float) -> void:
	max_value = max_hp
	value = current_hp
