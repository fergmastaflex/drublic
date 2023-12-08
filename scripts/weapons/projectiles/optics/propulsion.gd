extends OpticsProjectile

@onready var damage_radius = $DamageRadius
@onready var explosion_timer = $ExplosionTimer
@onready var explosion_particle = preload("res://scenes/weapons/projectiles/effects/archangel_explosion.tscn")

func _init():
	bullet_velocity = 100
	damage = 10

const DAMAGE_MULTIPLIER = 5.0

func give_damage(body):
	explosion_timer.start()
	super(body)

func emit_explosion():
	var new_explosion_particle = explosion_particle.instantiate()
	get_window().add_child.call_deferred(new_explosion_particle)
	new_explosion_particle.position = position
	new_explosion_particle.emitting = true

func explode():
	var bodies = $DamageRadius.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies") && body.has_method("take_damage") && body != weapon.ally:
			add_status_effect(body)
			body.take_damage(damage)

# func give_damage(_body):
# 	

	