extends Weapon

@export var attack_rate = 1
@export var damage  = 5
@onready var hitbox = $Hitbox


func try_attack(_weapon_mod):
	if !is_visible_in_tree() || still_attacking((attack_rate)):
		return
	last_attack_time = Time.get_ticks_msec()
	play_animation()
	var enemies = hitbox.get_overlapping_bodies()
	for enemy in enemies:
		if enemy.name != "Player" && enemy.has_method("take_damage"):
			enemy.take_damage(5)

