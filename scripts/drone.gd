extends CharacterBody3D
class_name Drone


# @onready var enemy = get_node("/root/MainScene/Enemy")
const SPEED = 8.0
const FABRICATE_AMOUNT = 200
var follow_distance : float = 2
var current_scrap = 0
var rng = RandomNumberGenerator.new()
var type_counts = {}

@onready var player = get_parent().get_node('Player')
@onready var holster = player.get_node('CameraOrbit/Holster')
@onready var ui = get_node("/root/MainScene/CanvasLayer/UI")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

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
