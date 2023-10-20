extends CharacterBody3D


# @onready var enemy = get_node("/root/MainScene/Enemy")
const SPEED = 2.0
var follow_distance : float = 1.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _process(_delta):
	var enemy = get_tree().get_nodes_in_group("enemies")[0]
	if enemy != null && position.distance_to(enemy.position) > follow_distance:
		var dir = (enemy.position - position).normalized()
		
		velocity.x = dir.x * SPEED
		velocity.y = 0
		velocity.z = dir.z * SPEED

	move_and_slide()

