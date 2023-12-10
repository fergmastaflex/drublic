extends ProjectileBase
class_name PropulsionProjectile

@onready var explosion_particle = preload("res://scenes/weapons/projectiles/effects/explosion_particle.tscn")
@onready var damage_collider = $DamageRadius/DamageCollider

func _init():
	bullet_velocity = 20
	damage = 30

func emit_explosion():
	var new_explosion_particle = explosion_particle.instantiate()
	get_window().add_child.call_deferred(new_explosion_particle)
	new_explosion_particle.position = position
	new_explosion_particle.emitting = true
	
func give_damage(_body):
	var bodies = $DamageRadius.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies") && body.has_method("take_damage") && !body.ally:
			add_status_effect(body)
			body.take_damage(damage)
	emit_explosion()
	damage_collider.set_deferred('disabled', true)
