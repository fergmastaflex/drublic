extends BioticsProjectile

func _init():
	damage = 2
	status_effect_chance = 5.0
	status_effect_scene = load('res://scenes/components/status_effects/volatile_component.tscn')
