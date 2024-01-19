extends BioticsProjectile

func _init():
	status_effect_chance = 50.0
	status_effect_scene = load('res://scenes/components/status_effects/freeze_component.tscn')

func try_status_effect(body):
	var status_effect = status_effect_scene.instantiate()
	var freeze_component = body.get_node_or_null(NodePath(status_effect.name))
	var random_number = rng.randf_range(0.0, 100.0)

	if random_number <= status_effect_chance:
		if !freeze_component:
			body.add_child(status_effect)
		else:
			freeze_component.add_stack()
			status_effect.queue_free()
