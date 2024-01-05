extends Weapon

##################################################################
# BIG EFFIN' NOTE: I can see turrets getting kinda hairy. I think we should make sure to
# abstract some of this at some point to so the weapon system is a little more accomidating to the turrets
# but without breaking everything
##################################################################

@onready var player = get_node("/root/MainScene/Player")
@onready var deploy_unit = $DeployUnit
#TODO: Make it a shotgun instead
################################
@onready var pistol = $Pistol
################################

var damage = 0
var deployed = false

const TURRET_FOLDER_BASE = "res://scenes/weapons/projectiles/robotics/turrets/"

func _process(_delta):
	set_ammo_scene()
	if deployed:
		pistol.visible = true
		deploy_unit.visible = false
	else:
		deploy_unit.visible = true
		pistol.visible = false

func try_attack():
	set_ammo_scene()
	if !is_visible_in_tree():
		return
	if deployed:
		pistol.try_attack()
	else:
		var turret = ammo_scene.instantiate()
		turret.position = player.position
		turret.position.x += -2
		turret.position.y += 1
		get_window().add_child.call_deferred(turret)
		deployed = true

func _init():
	base_weapon_type = Global.WeaponTypes.ROBOTICS

func set_ammo_scene():
	# If the base weapon is set to "BASE," that means there isn't a weapon present
	if base_weapon_type == Global.WeaponTypes.BASE:
		print(base_weapon_type)
		return
		
	var ammo_type_name : String
	if ammo_type:
		ammo_type_name = Global.WeaponTypes.keys()[ammo_type].to_snake_case()
	else:
		ammo_type_name = "robotics_projectile"

	var scene_path = str(TURRET_FOLDER_BASE, ammo_type_name, '.tscn')

	if ammo_scene && ammo_scene.resource_path == scene_path:
		return
		
	ammo_scene = load(scene_path)
