extends RigidBody3D
class_name ProjectileBase

var bullet_velocity : int
var rng = RandomNumberGenerator.new()
var status_effect_chance = 0.0
var status_effect_scene : PackedScene
var damage : float

@onready var projectile_collider = $ProjectileCollider
@onready var despawn_timer = find_child('DespawnTimer')

# Called when the node enters the scene tree for the first time.

func _ready():
	continuous_cd = true
	set_as_top_level(true)

func add_status_effect(body):
	if status_effect_scene:
		var random_number = rng.randf_range(0.0, 100.0)
		if random_number < status_effect_chance:
			if body.is_in_group("enemies"):
				var status_effect = status_effect_scene.instantiate()
				body.add_child(status_effect)

func handle_impact(body):
	# visible = false
	# projectile_collider.set_deferred("disabled", true)
	
	give_damage(body)

func give_damage(_body):
	push_error("Must be overridden by child")

func destroy():
	queue_free()
