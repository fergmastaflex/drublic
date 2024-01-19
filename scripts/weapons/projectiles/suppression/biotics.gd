extends Area3D

var rng = RandomNumberGenerator.new()
var status_effect_chance = 100.0
var status_effect_scene = load('res://scenes/components/status_effects/dot_component.tscn')
var heal_amount = 2.0

func heal_or_hurt():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies") && !body.ally:
			try_status_effect(body)
		elif body.has_method('heal'):
			body.heal(heal_amount)

func try_status_effect(body):
	var random_number = rng.randf_range(0.0, 100.0)
	var status_effect = status_effect_scene.instantiate()
	if random_number <= status_effect_chance && !body.has_node(NodePath(status_effect.name)):
		body.add_child(status_effect)
	else:
		status_effect.queue_free()
