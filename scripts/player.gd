extends CharacterBody3D

var curHp : int = 10
var maxHp : int = 10
var damage : float = 3.0
var attackRate : float = 1.5
var lastAttackTime : int = 0
var jumpCount : int = 0
var movement_speed : float = 2.8
var max_jumps : int = 1
var vel : Vector3 = Vector3()
var type_counts = {
	"ballistics": 0,
	"propulsion": 0,
	"suppression": 0,
	"robotics": 0,
	"optics": 0
}

@onready var camera = get_node("CameraOrbit")
# @onready var attackRayCast = get_node("AttackRayCast")
@onready var animation_player = get_node("Visuals/mixamo_base/AnimationPlayer")
@onready var ui = get_node("/root/MainScene/CanvasLayer/UI")
@onready var visuals = get_node("Visuals")
@onready var basher = $WeaponHolder/Basher
@onready var grenade_launcher = $WeaponHolder/GrenadeLauncher
@onready var sniper = $WeaponHolder/Sniper
@onready var shield = $WeaponHolder/Shield
@onready var turret = $WeaponHolder/Turret
@onready var pistol = $WeaponHolder/Pistol
@onready var assault_rifle = $WeaponHolder/AssaultRifle

@export var sens_horizontal = 0.5
@export var sens_vertical = 0.5

var current_weapon_base = NONE_TYPE
var current_weapon_mod = NONE_TYPE

const JUMP_VELOCITY = 5.0
const FABRICATE_AMOUNT = 100
const BALLISTICS_TYPE = "ballistics"
const PROPULSION_TYPE = "propulsion"
const OPTICS_TYPE = "optics"
const ROBOTICS_TYPE = "robotics"
const SUPPRESSION_TYPE = "suppression"
const NONE_TYPE = 'none'

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	ui.update_health_bar(curHp, maxHp)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x*sens_horizontal))
		camera.rotate_x(deg_to_rad(-event.relative.y*sens_vertical))
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-50.0), deg_to_rad(90.0))

func _process(_delta):
	set_current_weapon()

	if current_scrap() >= FABRICATE_AMOUNT && can_upgrade():
		ui.show_fabricate_message()
	else:
		ui.remove_fabricate_message()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if is_on_floor():
		jumpCount = 0

	# Handle Jump.
	if Input.is_action_just_pressed("jump") && (is_on_floor() || jumpCount < max_jumps):
		velocity.y = JUMP_VELOCITY
		jumpCount += 1
	
	if Input.is_action_just_pressed("fabricate"):
		fabricate_weapon()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if animation_player.current_animation != "walking":
			animation_player.play("walking")
		velocity.x = direction.x * movement_speed
		velocity.z = direction.z * movement_speed
	else:
		if animation_player.current_animation != "idle":
			animation_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, movement_speed)
		velocity.z = move_toward(velocity.z, 0, movement_speed)

	move_and_slide()
	
func give_scrap(amountToIncrease, type):	
	type_counts[type] += amountToIncrease
	ui.update_scrap_count(current_scrap())

func can_upgrade():
	return current_weapon_base == NONE_TYPE

func fabricate():
	if current_weapon_base == NONE_TYPE:
		fabricate_weapon()
	else:
		return
	# TODO: add logic for drone and ability upgrade

func fabricate_weapon():
	if current_scrap() >= FABRICATE_AMOUNT:
		set_weapon_base_and_mod()
		zero_counts()

func set_weapon_base_and_mod():
	var highest = -999999
	var second_highest = highest + 1
	for type in type_counts:
		var val = type_counts[type]
		if val > highest:
			highest = val
			current_weapon_base = type
		elif val > second_highest:
			second_highest = val
			current_weapon_mod = type

func set_current_weapon():
	if current_weapon_base == NONE_TYPE:
		basher.visible = true
	else:
		basher.visible = false
	
	if current_weapon_base == BALLISTICS_TYPE:
		assault_rifle.visible = true
	else:
		assault_rifle.visible = false
	
	if current_weapon_base == SUPPRESSION_TYPE:
		basher.visible = true
		shield.visible = true
	else:
		shield.visible = false

	if current_weapon_base == PROPULSION_TYPE:
		grenade_launcher.visible = true
	else:
		grenade_launcher.visible = false
	
	if current_weapon_base == ROBOTICS_TYPE:
		if turret.is_deployed():
			pistol.visible = true
			turret.visible = false
		else:
			pistol.visible = false
			turret.visible = true
	else:
		turret.visible = false
	
	if current_weapon_base == OPTICS_TYPE:
		sniper.visible = true
	else:
		sniper.visible = false

func zero_counts():
	type_counts = {
		"ballistics": 0,
		"propulsion": 0,
		"suppression": 0,
		"robotics": 0,
		"optics": 0
	}

func take_damage(damageToTake):
	curHp -= damageToTake
	ui.update_health_bar(curHp, maxHp)

	if curHp <= 0:
		die()

func die():
	get_tree().reload_current_scene()

func fill_hp():
	curHp = maxHp
	ui.update_health_bar(curHp, maxHp)

func current_scrap():
	return type_counts.values().reduce(sum, 0)

func sum(accum, number):
	return accum + number
		
	
