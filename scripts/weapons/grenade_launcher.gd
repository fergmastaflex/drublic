extends Weapon

@onready var grenade = preload("res://scenes/weapons/projectiles/grenade.tscn")
@onready var main_scene = get_node("/root/MainScene")
var attack_rate = 1.5

func try_attack():
	if !is_visible_in_tree() || still_attacking(attack_rate):
		return
	last_attack_time = Time.get_ticks_msec()
	play_animation()
	var fired_grenade = grenade.instantiate()
	add_sibling(fired_grenade)
	fired_grenade.global_transform = $Marker3D.global_transform
	fired_grenade.apply_central_force(-self.global_transform.basis.z * 50)

func weapon_type():
	return Holster.WeaponTypes.PROPULSION
