extends Area3D
class_name MagnetComponent

@onready var velocity_component = $VelocityComponent
@onready var seek_component = $SeekComponent

var max_force : float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	var enemy
	var targets = get_overlapping_bodies()
	if targets:
		for target in targets:
			if target.is_in_group("enemies") && !target.ally:
				enemy = target
	if enemy:
		velocity_component.apply_force(get_parent(), seek_component.run(enemy.global_position, global_position, max_force))
