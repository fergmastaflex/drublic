extends OpticsProjectile

func _init():
	super()
	damage = 5
	status_effect_chance = 25.0
	status_effect_scene = load('res://scenes/components/status_effects/dot_component.tscn')
