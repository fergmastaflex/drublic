extends Node3D

class_name Weapon

var last_attack_time : int = 0

@onready var weapon_animation = $WeaponAnimation
@onready var holster = get_parent()

var weapon_mod

func play_animation():
	weapon_animation.stop()
	weapon_animation.play("attack")

func try_attack():
	# because they don't have a way to raise an error in godot script
	# and I have SOME standards, OK?
	assert(true == false, "Must be defined by child class")

func still_attacking(attack_rate) -> bool:
	if (Time.get_ticks_msec() - last_attack_time) < (attack_rate * 1000):
		return true
	return false
