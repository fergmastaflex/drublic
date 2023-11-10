extends RigidBody3D

var shoot = false
const SPEED = 10.0
var damage = 30
var detonated = false
@onready var explosion_particle = $DamageRadius/ExplosionParticle
@onready var despawn_timer = $DespawnTimer
@onready var shell = $Shell

func _ready():
	set_as_top_level(true)

func _physics_process(_delta):
	if shoot:
		apply_impulse(transform.basis.z, -transform.basis.z)

func destroy():
	queue_free()
	
func detonate(_body):
	shoot = false
	shell.visible = false
	detonated = true
	despawn_timer.start()
	explosion_particle.emitting = true
	for body in $DamageRadius.get_overlapping_bodies():
		print(body)
		if body.is_in_group("enemies") && body.has_method("take_damage"):
			body.take_damage(damage)


func _on_despawn_timer_timeout():
	destroy()
