extends BioticsProjectile

@onready var raycast = $RayCast3D
@onready var healing_area_scene = preload("res://scenes/weapons/projectiles/effects/healing_area.tscn")
@onready var player = get_node("/root/MainScene/Player")

func _init():
	damage = 7
	status_effect_chance = 5.0
	status_effect_scene = load('res://scenes/components/status_effects/dot_component.tscn')

func give_damage():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies") && !body.ally:
			body.take_damage(damage)
			try_status_effect(body)
		elif body.is_in_group('players'):
			body.heal(damage)

	if raycast.get_collider() is StaticBody3D:
		var healing_area = healing_area_scene.instantiate()
		var collision_point = raycast.get_collision_point()
		get_window().add_child.call_deferred(healing_area)
		await healing_area.ready
		healing_area.global_position = collision_point
	
