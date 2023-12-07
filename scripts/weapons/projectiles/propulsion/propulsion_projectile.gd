extends ProjectileBase
class_name PropulsionProjectile

@onready var explosion_particle = preload("res://scenes/weapons/projectiles/propulsion/effects/explosion_particle.tscn")

@onready var weapon = get_parent()
@onready var damage_collider = $DamageRadius/DamageCollider

func emit_explosion():
	var new_explosion_particle = explosion_particle.instantiate()
	add_sibling(new_explosion_particle)
	new_explosion_particle.set_as_top_level(true)
	new_explosion_particle.position = position
	new_explosion_particle.emitting = true
	
func give_damage(_body):
	var bodies = $DamageRadius.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies") && body.has_method("take_damage") && body != weapon.ally:
			add_status_effect(body)
			body.take_damage(damage)
			print(damage)
	emit_explosion()
	queue_free()

# func disable_projectile():
# 	super()
# 	damage_collider.disabled = true
