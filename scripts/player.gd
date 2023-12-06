extends CharacterBody3D

var current_hp : int = 10
var max_hp : int = 100
var attackRate : float = 1.5
var jumpCount : int = 0
var walk_speed : float = 2.8
var run_speed : float = 5.6
var max_jumps : int = 1



@onready var camera = get_node("CameraOrbit")
@onready var animation_player = get_node("Visuals/mixamo_base/AnimationPlayer")
@onready var ui = get_node("/root/MainScene/CanvasLayer/UI")
@onready var visuals = get_node("Visuals")
@onready var holster = $CameraOrbit/Holster
@onready var drone = get_parent().get_node('Drone')
@onready var basher = $Basher
@onready var health_component = $HealthComponent


@export var sens_horizontal = 0.5
@export var sens_vertical = 0.5

const JUMP_VELOCITY = 5.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	ui.update_health_bar(current_hp, max_hp)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x*sens_horizontal))
		camera.rotate_x(deg_to_rad(-event.relative.y*sens_vertical))
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-50.0), deg_to_rad(90.0))

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
		if Input.is_action_pressed("sprint"):
			if animation_player.current_animation != "running":
				animation_player.play("running")
			velocity.x = direction.x * run_speed
			velocity.z = direction.z * run_speed
		else:
			if animation_player.current_animation != "walking":
				animation_player.play("walking")
			velocity.x = direction.x * walk_speed
			velocity.z = direction.z * walk_speed
	else:
		if animation_player.current_animation != "idle":
			animation_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, walk_speed)
		velocity.z = move_toward(velocity.z, 0, walk_speed)

	var holstered_weapon = holster.current_weapon

	if holstered_weapon:
		if Input.is_action_pressed("aim"):
			basher.visible = false
			holstered_weapon.visible = true
		else:
			holstered_weapon.visible = false

	if Input.is_action_just_pressed("attack"):
		if Input.is_action_pressed("aim"):
			if !holster.empty():
				holstered_weapon.try_attack()
		else:
			basher.try_attack()
	

	move_and_slide()
	
# is there a way to delegate?
func give_scrap(scrap_amount, scrap_type):
	drone.give_scrap(scrap_amount, scrap_type)

func take_damage(damageToTake):
	current_hp -= damageToTake
	ui.update_health_bar(current_hp, max_hp)

	if current_hp <= 0:
		die()

func heal(damage_to_heal):
	current_hp += damage_to_heal
	ui.update_health_bar(current_hp, max_hp)

func die():
	get_tree().reload_current_scene()

func fill_hp():
	current_hp = max_hp
	ui.update_health_bar(current_hp, max_hp)

func sum(accum, number):
	return accum + number
