extends CharacterBody3D
class_name Drone


# @onready var enemy = get_node("/root/MainScene/Enemy")
const ACCELERATION = 0.5
const FABRICATE_AMOUNT = 200
const MAX_SPEED = 8.0
var follow_distance : float = 2
var current_scrap = 0
var rng = RandomNumberGenerator.new()
var type_counts = {}
var target : Vector3 = self.global_position
# var _velocity = Vector3.ZERO

@onready var player = get_parent().get_node('Player')
@onready var drone_starting_point = player.get_node('DroneRestMarker')
@onready var holster = player.get_node('CameraOrbit/Holster')
@onready var ui = get_node("/root/MainScene/CanvasLayer/UI")
@onready var velocity_component : Node = $VelocityComponent
@onready var seek_component : Node = $SeekComponent

# Get the gravity from the project settings to be synced with RigidBody nodes.
# var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	zero_type_counts()

func _process(_delta):
	if current_scrap >= FABRICATE_AMOUNT && holster.empty():
		ui.show_fabricate_message()
	else:
		ui.remove_fabricate_message()

	if Input.is_action_just_pressed("fabricate"):
		fabricate_weapon()

func _physics_process(_delta):
	var scrap = get_tree().get_nodes_in_group("scrap")
	
	if scrap:
		target = scrap[0].global_position
	else:
		target = drone_starting_point.global_position
	# target = 
	velocity_component.apply_force(seek_component.run(target, global_position, velocity_component.max_speed, velocity_component.arrive_threshhold))
	velocity_component.move(self)
	# var force : Vector3
	# var target : Vector3 = (self.global_position - drone_starting_point.global_position).normalized()
	# # var distance = (self.global_position - drone_starting_point.global_position).length()
	# # target = target.normalized()
	# if self.global_position.distance_to(drone_starting_point.global_position) < follow_distance:
	# 	pass
	# 	force = (target * distance).limit_length(MAX_SPEED)
	# else:
	# 	force = target * MAX_SPEED
	
	
	
	
	# var scrap = get_tree().get_nodes_in_group("scrap")
	# var target
	# var speed
	# var distance = position.distance_to(drone_starting_point.global_position)

	# var target = drone_starting_point.global_position

	# print(position.distance_to(drone_starting_point.global_position))
	# if scrap:
	# 	target = (scrap[0].global_position - global_position).normalized()
	# 	# move_towards_target(scrap[0], delta)
	# else:
	# 	target = (drone_starting_point.global_position - global_position).normalized()

	# if distance < follow_distance:
	# 	speed = 0.1
	# else:
	# 	speed = 9.0

	# # velocity = velocity.lerp(target * speed, ACCELERATION * delta)
	

	# # 	
	# # else:
	# # 	print('not home')
	# # 	velocity = player.velocity
	# # 	print('here')
	# # 	velocity = player.velocity
	# # 	rotation = player.rotation
	
	
	# velocity.y = 0

	# var current_direction = velocity.normalized()
	# var current_speed = velocity.length()


	rotation = player.rotation
	# # if current_speed >= speed:
	# # 	velocity = current_direction * speed
	# print(speed)
	# move_and_slide()

# func move_towards_target(target, delta):

# 	var current_direction = velocity.normalized()
# 	var current_speed = velocity.length()

	# if current_speed >= SPEED:
	# 	velocity = current_direction * SPEED

	# if position.distance_to(target.position) <= follow_distance:
	# 	velocity.x += -change_in_vel.x
	# 	velocity.z += -change_in_vel.z
	# 	velocity.y = 0


func give_scrap(amountToIncrease, type):
	current_scrap += amountToIncrease
	type_counts[type] += amountToIncrease
	ui.update_scrap_count(current_scrap)
	# ui.update_type_total(type_counts)

func fabricate_weapon():
	if current_scrap >= FABRICATE_AMOUNT && holster.empty():
		holster.set_current_weapon(Holster.WeaponTypes[random_weighted_scrap()])
		# holster.current_weapon.current_weapon_mod = random_weighted_scrap()
		current_scrap -= FABRICATE_AMOUNT
		player.fill_hp()
	zero_type_counts()

func random_weighted_scrap(skip = ''):
	var pool = []
	for type in type_counts:
		if type == skip:
			continue
		for i in range(type_counts[type]):
			pool.append(type)
	return pool[randi() % pool.size()]

func zero_type_counts():
	for type in Holster.WeaponTypes:
		type_counts[type] = 0
	
	# ui.update_type_total(type_counts)
