extends ProjectileBase
class_name OpticsProjectile

func _init():
	bullet_velocity = 100
	damage = 25
	projectile_collider = null
	
func give_damage(body):
	if body.is_in_group("enemies") && body.has_method("take_damage") && !body.ally:
		add_status_effect(body)
		body.take_damage(damage)
		