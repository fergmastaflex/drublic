extends CharacterBody3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var body = $Body
# TODO: Just doing sniper for now. will make this dynamic
@onready var gun = $Body/Sniper


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies:
		var enemy = enemies[0]
		gun.look_at(enemy.global_position, Vector3.UP)
		gun.try_attack()
	body.rotation.x = clamp(body.rotation.x, deg_to_rad(-50.0), deg_to_rad(90.0))
	
	move_and_slide()
