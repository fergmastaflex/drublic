extends CharacterBody3D
class_name Enemy

const SPEED = 2.0

var rng = RandomNumberGenerator.new()
var current_hp : float = rng.randf_range(20.0, 50.0)
var attack_range : float = 1.5
var attack_rate : float = 1.0
var damage: int = 0
var is_stunned = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var player = get_node("/root/MainScene/Player")
@onready var scrap_scene = preload("res://scenes/scrap.tscn")
@onready var stun_label = $StunLabel

func _ready():
	add_to_group("enemies")

func _physics_process(delta):
		# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if is_stunned:
		stun_label.visible = true
		return
	else:
		stun_label.visible = false

	if position.distance_to(player.position) > attack_range:
		var dir = (player.position - position).normalized()
		
		velocity.x = dir.x * SPEED
		velocity.y = 0
		velocity.z = dir.z * SPEED

	move_and_slide()


func _on_timer_timeout():
	if position.distance_to(player.position) <= attack_range:
		player.take_damage(damage)

func take_damage(damage_to_take):
	current_hp -= damage_to_take
	if is_stunned:
		damage_to_take *= 1.2
	if current_hp <= 0:
		die()

func die():
	#drop between 1 and 3 scrap
	for i in rng.randi_range(1,3):
		var scrap = scrap_scene.instantiate()
		add_sibling(scrap)
		scrap.position = position
		scrap.position.x += i
	queue_free()
