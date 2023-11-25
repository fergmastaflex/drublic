extends CharacterBody3D
class_name Drone


# @onready var enemy = get_node("/root/MainScene/Enemy")
const FABRICATE_AMOUNT = 200
var follow_distance : float = 2
var current_scrap = 0
var rng = RandomNumberGenerator.new()
var type_counts = {}
var target : Vector3 = self.global_position

@onready var player = get_parent().get_node('Player')
@onready var drone_starting_point = player.get_node('DroneRestMarker')
@onready var holster = player.get_node('CameraOrbit/Holster')
@onready var ui = get_node("/root/MainScene/CanvasLayer/UI")
@onready var velocity_component : Node = $VelocityComponent

func _ready():
	zero_type_counts()

func _process(_delta):
	var scrap = get_tree().get_nodes_in_group("scrap")
	if scrap:
		target = scrap[0].drone_target.global_position
	else:
		target = drone_starting_point.global_position

	if current_scrap >= FABRICATE_AMOUNT && holster.empty():
		ui.show_fabricate_message()
	else:
		ui.remove_fabricate_message()

	if Input.is_action_just_pressed("fabricate"):
		fabricate_weapon()

func _physics_process(_delta):
	var force : Vector3
	var desired : Vector3 = target - position
	var distance : float = desired.length()
	desired = desired.normalized()

	if distance < velocity_component.arrive_threshhold:
		force = (desired * distance).limit_length(velocity_component.max_speed)
	else:
		force = desired * velocity_component.max_speed

	velocity_component.apply_force(force)
	velocity_component.move(self)
	velocity = velocity_component.velocity
	move_and_slide()


func give_scrap(amountToIncrease, type):
	current_scrap += amountToIncrease
	type_counts[type] += amountToIncrease
	ui.update_scrap_count(current_scrap)

func fabricate_weapon():
	if current_scrap >= FABRICATE_AMOUNT && holster.empty():
		holster.set_current_weapon(Global.WeaponTypes[random_weighted_scrap()])
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
	for type in Global.WeaponTypes:
		type_counts[type] = 0
