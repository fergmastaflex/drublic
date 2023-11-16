extends RigidBody3D

var shoot = false
const SPEED = 10.0
var damage = 30
var detonated = false
@onready var despawn_timer = $DespawnTimer
@onready var shell = $Shell
@onready var explosion_particle = preload("res://scenes/weapons/projectiles/explosion_particle.tscn")
@onready var main_scene = get_node('/root/MainScene')

func _ready():
	set_as_top_level(true)

func _physics_process(_delta):
	if shoot:
		apply_impulse(transform.basis.z, -transform.basis.z)
	
func detonate(_body):
	var new_explosion_particle = explosion_particle.instantiate()
	main_scene.add_child(new_explosion_particle)
	new_explosion_particle.position = position
	new_explosion_particle.emitting = true

	var bodies = $DamageRadius.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies") && body.has_method("take_damage"):
			body.take_damage(damage)
	queue_free()
