extends RigidBody3D
class_name OpticsProjectile

var damage = 25
var bullet_velocity = 500
@onready var shell = $Shell

func _ready():
	set_as_top_level(true)
	
func give_damage(body):
	if body.is_in_group("enemies") && body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()
