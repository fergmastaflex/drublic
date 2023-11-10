extends Weapon

@onready var grenade = preload("res://grenade.tscn")
@onready var main_scene = get_node("/root/MainScene")
var attack_rate = 1.5

func try_attack(_weapon_mod):
	if !is_visible_in_tree() || still_attacking(attack_rate):
		return
	last_attack_time = Time.get_ticks_msec()
	play_animation()
	var fired_grenade = grenade.instantiate()
	main_scene.add_child(fired_grenade)
	fired_grenade.global_transform = $Marker3D.global_transform
	fired_grenade.apply_central_force(-self.global_transform.basis.z * 1000)

