extends Weapon

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var body = $Body
@onready var gun = $Body/Gun

const ROBOTICS_PROJECTILE_BASE_FOLDER = "res://scenes/weapons/projectiles/robotics/turret_projectiles/base.tscn"

# func _init():
# 	attack_rate = 1.0
# 	ammo_scene = load(ROBOTICS_PROJECTILE_BASE_FOLDER)
# 	# marker = $Body/Gun/Marker3D

func _ready():
	set_as_top_level(true)
	marker = $Body/Gun/Marker3D
	ammo_scene = load(ROBOTICS_PROJECTILE_BASE_FOLDER)
	attack_rate = 1.0

# TODO: ANIMATE THIS SHIT
func play_animation():
	pass

func _physics_process(delta):
	# Add the gravity.
	if not body.is_on_floor():
		body.velocity.y -= gravity * delta
	
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies:
		var enemy = enemies[0]
		gun.look_at(enemy.global_position, Vector3.UP)
		try_attack()
	
	body.move_and_slide()

func try_attack():
	if !is_visible_in_tree() || still_attacking():
		return
	last_attack_time = Time.get_ticks_msec()
	play_animation()
	if ammo_scene:
		var projectile = ammo_scene.instantiate()
		add_sibling(projectile)
		
		projectile.global_transform = marker.global_transform
		projectile.apply_central_impulse(-gun.global_transform.basis.z * projectile.bullet_velocity)
