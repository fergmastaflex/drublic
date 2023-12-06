extends PropulsionProjectile

var rng = RandomNumberGenerator.new()
@onready var stun_component = preload('res://scenes/components/status_effects/stun_component.tscn')
const STUN_CHANCE = 30.0

func give_damage(_body):
	var new_explosion_particle = explosion_particle.instantiate()
	main_scene.add_child(new_explosion_particle)
	new_explosion_particle.position = position
	new_explosion_particle.emitting = true

	var bodies = $DamageRadius.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies") && body.has_method("take_damage"):
			var stun_check = rng.randf_range(0.0, 100.0)
			if stun_check < STUN_CHANCE:
				var stun = stun_component.instantiate()
				body.add_child(stun)
			body.take_damage(damage)
	queue_free()