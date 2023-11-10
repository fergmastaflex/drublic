extends CharacterBody3D
class_name Drone


# @onready var enemy = get_node("/root/MainScene/Enemy")
const SPEED = 8.0
var follow_distance : float = 2
@onready var player = get_parent().get_node("Player")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(_delta):
	var scrap = get_tree().get_nodes_in_group("scrap")
	if scrap:
		move_towards_target(scrap[0])
	else:
		move_towards_target()
	move_and_slide()

func move_towards_target(target = player):
	var dir = (target.position - position).normalized()
	if position.distance_to(player.position) > follow_distance:
		velocity.x = dir.x * SPEED
		velocity.y = 0
		velocity.z = dir.z * SPEED

# is there a way to delegate?
func give_scrap(scrap_amount, scrap_type):
	player.give_scrap(scrap_amount, scrap_type)