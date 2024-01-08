extends RigidBody3D
class_name ProjectileBase

var bullet_velocity : float
var rng = RandomNumberGenerator.new()
var status_effect_chance = 0.0
var status_effect_scene : PackedScene
var damage : float

@onready var projectile_collider = $ProjectileCollider
@onready var despawn_timer = find_child('DespawnTimer')
@onready var player = get_node("/root/MainScene/Player")

# Called when the node enters the scene tree for the first time.

func _ready():
	continuous_cd = true
	add_to_group("player_projectiles")
	set_as_top_level(true)

func add_status_effect(body):
	if status_effect_scene:
		var random_number = rng.randf_range(0.0, 100.0)
		var status_effect = status_effect_scene.instantiate()
		if random_number <= status_effect_chance && !body.has_node(NodePath(status_effect.name)):
			body.add_child(status_effect)
		else:
			status_effect.queue_free()

func handle_impact(body):
	visible = false
	projectile_collider.set_deferred("disabled", true)
	
	give_damage(body)

func give_damage(_body):
	push_error("Must be overridden by child")

func destroy():
	queue_free()
