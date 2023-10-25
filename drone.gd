extends CharacterBody3D


# @onready var enemy = get_node("/root/MainScene/Enemy")
const SPEED = 2.0
var follow_distance : float = 2
@onready var player = get_parent().get_node("Player")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(_delta):
	# var enemy = get_tree().get_nodes_in_group("enemies")[0]
	# if enemy != null && position.distance_to(enemy.position) > follow_distance:
	# 	var dir = (enemy.position - position).normalized()
		
	# 	velocity.x = dir.x * SPEED
	# 	velocity.y = 0
	# 	velocity.z = dir.z * SPEED
	# else:
	var dir = (player.position - position).normalized()
	if position.distance_to(player.position) > follow_distance: 
	# 	look_at(player.position)

	
		velocity.x = dir.x * SPEED
		velocity.y = 0
		velocity.z = dir.z * SPEED


	move_and_slide()

