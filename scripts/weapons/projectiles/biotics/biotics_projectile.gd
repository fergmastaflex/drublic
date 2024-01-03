extends Area3D
class_name BioticsProjectile

var damage = 5
@onready var particle = $Particle

func give_damage():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		print(body)
		if body.is_in_group("enemies") && !body.ally:
			body.take_damage(damage) 
