extends ProjectileBase
class_name PistolProjectile

func _init():
	damage = 5.0
	bullet_velocity = 50.0
	
func give_damage(body):
	if body.is_in_group("enemies") && body.has_method("take_damage"):
		body.take_damage(damage)
