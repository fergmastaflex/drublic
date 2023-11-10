extends RigidBody3D

var speed = 10.0
var damage = 30
var detonated = false
@onready var explosion_particle = $DamageRadius/ExplosionParticle
@onready var despawn_timer = $DespawnTimer
@onready var shell = $Shell

func destroy():
	queue_free()
	
func detonate(_body):
	if detonated:
		return
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
