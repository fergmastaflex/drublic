extends Weapon

@onready var base = preload("res://scenes/weapons/projectiles/propulsion/base.tscn")
@onready var robotics = preload("res://scenes/weapons/projectiles/propulsion/robotics.tscn")
@onready var optics = preload("res://scenes/weapons/projectiles/propulsion/robotics.tscn")
@onready var main_scene = get_node("/root/MainScene")

const AMMO_FOLDER = "res://scenes/weapons/projectiles/grenades"

# func try_attack():
# 	if !is_visible_in_tree() || still_attacking():
# 		return
# 	last_attack_time = Time.get_ticks_msec()
# 	play_animation()
# 	var fired_grenade = base.instantiate()
# 	add_sibling(fired_grenade)
# 	fired_grenade.global_transform = $Marker3D.global_transform
# 	fired_grenade.apply_central_force(-self.global_transform.basis.z * 50)
	
func base_weapon_type():
	return Global.WeaponTypes.PROPULSION