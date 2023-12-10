extends Node3D

class_name Weapon

var last_attack_time : int = 0
var ammo_scene
var base_weapon_type : Global.WeaponTypes = Global.WeaponTypes.BASE
var ally : Enemy
@export var attack_rate = 0.0
@export var ammo_type : Global.WeaponTypes

@onready var weapon_animation = $WeaponAnimation
@onready var holster = get_parent()
@onready var marker = $Marker3D


const PROJECTILE_BASE_FOLDER = "res://scenes/weapons/projectiles/"

func play_animation():
	weapon_animation.stop()
	weapon_animation.play("attack")

func try_attack():
	if !is_visible_in_tree() || still_attacking():
		return
	last_attack_time = Time.get_ticks_msec()
	play_animation()
	if ammo_scene:
		var projectile = ammo_scene.instantiate()
		add_sibling(projectile)
		projectile.global_transform = marker.global_transform
		projectile.apply_central_impulse(-self.global_transform.basis.z * projectile.bullet_velocity)

func still_attacking() -> bool:
	if (Time.get_ticks_msec() - last_attack_time) < (attack_rate * 1000):
		return true
	return false

func set_ammo_scene():
	# If the base weapon is set to "BASE," that means there isn't a weapon present
	if base_weapon_type == Global.WeaponTypes.BASE:
		return
	var base_weapon_type_name = Global.enum_to_string(base_weapon_type).to_snake_case()
	var ammo_type_name : String
	if ammo_type:
		ammo_type_name = Global.WeaponTypes.keys()[ammo_type].to_snake_case()
	else:
		ammo_type_name = str(base_weapon_type_name,"_projectile")

	# Is there a better way here?
	var scene_path = str(PROJECTILE_BASE_FOLDER, base_weapon_type_name, "/", ammo_type_name, '.tscn')
	
	ammo_scene = load(scene_path)

