extends Area3D
class_name BioticsProjectile

var damage = 5
@onready var particle = $Particle
var rng = RandomNumberGenerator.new()
var status_effect_chance = 0.0
var status_effect_scene : PackedScene

func give_damage():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies") && !body.ally:
			body.take_damage(damage)
			try_status_effect(body)

func try_status_effect(body):
	if status_effect_scene:
		var random_number = rng.randf_range(0.0, 100.0)
		var status_effect = status_effect_scene.instantiate()
		if random_number <= status_effect_chance && !body.has_node(NodePath(status_effect.name)):
			body.add_child(status_effect)
		else:
			status_effect.queue_free()
