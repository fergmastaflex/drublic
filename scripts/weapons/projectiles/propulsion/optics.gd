extends PropulsionProjectile

@onready var targeted_component = preload('res://scenes/components/status_effects/targeted_component.tscn')

func give_damage(_body):
	var new_explosion_particle = explosion_particle.instantiate()
	main_scene.add_child(new_explosion_particle)
	new_explosion_particle.position = position
	new_explosion_particle.emitting = true

	var bodies = $DamageRadius.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies") && body.has_method("take_damage"):
			var targeted = targeted_component.instantiate()
			body.add_child(targeted)
			body.take_damage(damage)
	queue_free()