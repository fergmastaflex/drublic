extends ProjectileBase
class_name OpticsProjectile

func _init():
	bullet_velocity = 100
	damage = 25
	
func give_damage(body):
	if body.is_in_group("enemies") && body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()
