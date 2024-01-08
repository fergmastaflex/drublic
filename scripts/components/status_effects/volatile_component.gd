extends Area3D

@onready var parent = get_parent()
@onready var explosion_particle = preload("res://scenes/weapons/projectiles/effects/explosion_particle.tscn")

var damage = 20

func _ready():
	parent.is_volatile = true

func trigger_explosion():
	var new_explosion_particle = explosion_particle.instantiate()
	get_tree().get_root().add_child(new_explosion_particle)
	new_explosion_particle.global_position = global_position
	new_explosion_particle.emitting = true
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies") && body.has_method("take_damage") && !body.ally:
			body.take_damage(damage)
	if is_instance_valid(parent):
		parent.is_volatile = false
	queue_free()