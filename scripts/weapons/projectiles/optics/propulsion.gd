extends OpticsProjectile

@onready var explosion_timer = $ExplosionTimer
@onready var explosion_particle_scene = preload("res://scenes/weapons/projectiles/effects/archangel_explosion.tscn")
var attached = false
var attach_point

func _init():
	bullet_velocity = 80
	damage = 10

const DAMAGE_MULTIPLIER = 5.0

func _process(_delta):
	if attached == true:
		if attach_point != null:
			global_transform.origin = attach_point.global_transform.origin
		else:
			explode()

func handle_impact(body):
	if attached == false:
		attached = true
		attach_point = Area3D.new()
		body.add_child(attach_point)
		attach_point.global_transform.origin = global_transform.origin
	explosion_timer.start()
	super(body)

func explode():
	var explosion_particle = explosion_particle_scene.instantiate()
	get_window().add_child.call_deferred(explosion_particle)
	explosion_particle.position = position
	explosion_particle.emitting = true

	var bodies = $DamageRadius.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies") && body.has_method("take_damage") && !body.ally:
			body.take_damage(damage * DAMAGE_MULTIPLIER)
	if is_instance_valid(attach_point):
		attach_point.queue_free()
	queue_free()
