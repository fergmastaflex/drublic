extends PropulsionProjectile

func _init():
	status_effect_chance = 25.0
	status_effect_scene = load('res://scenes/components/status_effects/stun_component.tscn')