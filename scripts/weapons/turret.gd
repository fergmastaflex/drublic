extends Weapon

@onready var player = get_node("/root/MainScene/Player")
var attack_rate = 1.0
var damage = 0
var deployed = false

func try_attack(_weapon_mod):
	if !is_visible_in_tree() || deployed == true:
		return
	var deployed_turret = load("res://turret_deployed.tscn")
	var turret = deployed_turret.instantiate()
	turret.position = player.position
	turret.position.x += -2
	turret.position.y += 1
	get_window().add_child(turret)
	deployed = true

func is_deployed():
	return deployed
