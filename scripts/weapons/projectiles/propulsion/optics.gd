extends PropulsionProjectile

func _init():
	damage = 25
	status_effect_chance = 25.0
	status_effect_scene = load('res://scenes/components/status_effects/targeted_component.tscn')