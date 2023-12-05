extends RigidBody3D
class_name PistolProjectileBase

var damage = 3.0
var bullet_velocity = 50

func _ready():
	set_as_top_level(true)
	
func give_damage(body):
	if body.is_in_group("enemies") && body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()
