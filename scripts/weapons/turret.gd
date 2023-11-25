extends Weapon

@onready var player = get_node("/root/MainScene/Player")
@onready var turret_scene = preload("res://scenes/weapons/projectiles/turret_deployed.tscn")
@onready var deploy_unit = $DeployUnit
@onready var pistol = $Pistol

var attack_rate = 1.0
var damage = 0
var deployed = false

func _process(_delta):
	if is_deployed():
		pistol.visible = true
		deploy_unit.visible = false
	else:
		deploy_unit.visible = true
		pistol.visible = false

func try_attack():
	if !is_visible_in_tree():
		return
	if !is_deployed():
		var turret = turret_scene.instantiate()
		turret.position = player.position
		turret.position.x += -2
		turret.position.y += 1
		get_window().add_child(turret)
		deployed = true
	else:
		pistol.try_attack()

func is_deployed():
	return deployed

func weapon_type():
	return Global.WeaponTypes.ROBOTICS
