extends Area3D

@onready var parent = get_parent()
@onready var explosion_timer = $ExplosionTimer
@onready var explosion_particle = preload("res://scenes/weapons/projectiles/effects/archangel_explosion.tscn")

@export var damage = 30

func _ready():
	explosion_timer.start()

func explode():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies") && body.has_method("take_damage") && !body.ally:
			body.take_damage(damage)

func emit_explosion():
	var new_explosion_particle = explosion_particle.instantiate()
	get_window().add_child.call_deferred(new_explosion_particle)
	new_explosion_particle.position = position
	new_explosion_particle.emitting = true
