extends SuppressionProjectile

var status_effect_scene = load('res://scenes/components/status_effects/targeted_component.tscn')

func perform_aura_action():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies") && !body.ally:
			var status_effect = status_effect_scene.instantiate()
			body.add_child(status_effect)