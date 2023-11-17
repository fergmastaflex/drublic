extends Weapon

@onready var attack_ray_cast = $AttackRayCast
var attack_rate = 0.5
var damage = 1

func try_attack():
	if !is_visible_in_tree() || still_attacking(attack_rate):
		return
	last_attack_time = Time.get_ticks_msec()
	play_animation()
	if attack_ray_cast.is_colliding():
		var collider = attack_ray_cast.get_collider()
		if collider.has_method("take_damage") && collider.name != "Player":
			attack_ray_cast.get_collider().take_damage(damage)

func weapon_type():
	return Holster.WeaponTypes.ROBOTICS