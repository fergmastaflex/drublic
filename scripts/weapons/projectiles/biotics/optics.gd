extends BioticsProjectile

func _init():
	damage = 4
	status_effect_chance = 30.0
	status_effect_scene = load('res://scenes/components/status_effects/targeted_component.tscn')

