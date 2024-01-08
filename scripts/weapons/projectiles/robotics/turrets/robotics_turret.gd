extends Weapon
class_name RoboticsTurret

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var turret_body = $TurretBody
@onready var gun = $TurretBody/Gun
var turret_ammo_scene = load(ROBOTICS_PROJECTILE_BASE_FOLDER)

const ROBOTICS_PROJECTILE_BASE_FOLDER = "res://scenes/weapons/projectiles/robotics/turret_projectiles/base.tscn"

func _ready():
	set_as_top_level(true)
	marker = $TurretBody/Gun/Marker3D
	attack_rate = 1.0

func _physics_process(delta):
	# Add the gravity.
	if not turret_body.is_on_floor():
		turret_body.velocity.y -= gravity * delta
	
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies && gun:
		var enemy = enemies[0]
		gun.look_at(enemy.global_position, Vector3.UP)
		try_attack()
	
	turret_body.move_and_slide()

func set_ammo_scene():
	pass

func try_attack():
	if !is_visible_in_tree() || still_attacking():
		return
	last_attack_time = Time.get_ticks_msec()

	if turret_ammo_scene:
		var projectile = turret_ammo_scene.instantiate()
		add_sibling(projectile)
		
		projectile.global_transform = marker.global_transform
		projectile.apply_central_impulse(-gun.global_transform.basis.z * projectile.bullet_velocity)
