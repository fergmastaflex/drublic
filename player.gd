extends CharacterBody3D

var curHp : int = 10
var maxHp : int = 10
var damage : float = 3.0
var electronics : int = 0
var propulsion : int = 0
var defense : int = 0
var biotics : int = 0
var optics : int = 0
var attackRate : float = 1.5
var lastAttackTime : int = 0
var jumpCount : int = 0
var currentScrap : int = 0
var movement_speed : float = 2.8
var max_jumps : int = 1


var vel : Vector3 = Vector3()

@onready var camera = get_node("CameraOrbit")
@onready var attackRayCast = get_node("AttackRayCast")
@onready var animation_player = get_node("Visuals/mixamo_base/AnimationPlayer")
@onready var weaponAnimation = get_node("WeaponHolder/WeaponAnimator")
@onready var ui = get_node("/root/MainScene/CanvasLayer/UI")
@onready var visuals = get_node("Visuals")

@export var sens_horizontal = 0.5
@export var sens_vertical = 0.5

const JUMP_VELOCITY = 5.0
const MAX_SCRAP = 100
const ELECTRONICS_TYPE = "electronics"
const PROPULSION_TYPE = "propulsion"
const DEFENSE_TYPE = "defense"
const OPTICS_TYPE = "optics"
const BIOTICS_TYPE = "electronics"


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
	if Input.is_action_just_pressed("attack"):
		try_attack()

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
	# We don't want to go over the max, so allow the pickup
	# but at a reduced amount 
	if currentScrap + amountToIncrease > MAX_SCRAP:
		amountToIncrease = MAX_SCRAP - currentScrap
		
	var newTypeTotal = get(type) + amountToIncrease
	set(type, newTypeTotal)
	currentScrap = electronics + propulsion + defense + biotics + optics
	if currentScrap == MAX_SCRAP:
		var scrapTotals = {"electronics": electronics,"propulsion": propulsion, "defense": defense, "biotics": biotics, "optics": optics}
		var powerup_type = find_largest_dict_val(scrapTotals)
		grant_powerup(powerup_type)
		zero_out_scrap()
	# this is temporary for debugging purposes!
	# I think we just want to do a progress bar for the scrap
	# but am open to feedback there.
	ui.update_scrap_bar(currentScrap, MAX_SCRAP)

func grant_powerup(powerup_type):
	var powerup_function = Callable(self, str("grant_", powerup_type))
	powerup_function.call()
	ui.update_powerup_text(powerup_type)
	fill_hp()

func grant_electronics():
	attackRate -= 0.2

func grant_propulsion():
	max_jumps += 1

func grant_defense():
	maxHp += 10

func grant_biotics():
	movement_speed += 0.3

func grant_optics():
	damage += 0.5

func zero_out_scrap():
	currentScrap = 0
	electronics = 0
	propulsion = 0
	defense = 0
	biotics = 0
	optics = 0

func find_largest_dict_val(scrap_type_totals):
	var max_val = -999999
	var winning_scrap_type
	for type in scrap_type_totals:
		var val =  scrap_type_totals[type]
		if val > max_val:
			max_val = val
			winning_scrap_type = type
	return winning_scrap_type

func take_damage(damageToTake):
	curHp -= damageToTake
	ui.update_health_bar(curHp, maxHp)

	if curHp <= 0:
		die()

func die():
	get_tree().reload_current_scene()
	
func try_attack():
	if Time.get_ticks_msec() - lastAttackTime < attackRate * 1000:
		return
	lastAttackTime = Time.get_ticks_msec()
	
	weaponAnimation.stop()
	weaponAnimation.play("attack")
	
	if attackRayCast.is_colliding():
		if attackRayCast.get_collider().has_method("take_damage"):
			attackRayCast.get_collider().take_damage(damage)

func fill_hp():
	curHp = maxHp
	ui.update_health_bar(curHp, maxHp)
		
	
