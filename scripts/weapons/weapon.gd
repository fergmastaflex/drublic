extends Node3D

class_name Weapon

var last_attack_time : int = 0
var current_weapon_mod = "none"

@onready var weapon_animation = $WeaponAnimation

func play_animation():
	weapon_animation.stop()
	weapon_animation.play("attack")

func _process(_delta):
	if Input.is_action_just_pressed("attack"):
		try_attack(current_weapon_mod)

func try_attack(_weapon_mod):
	# because they don't have a way to raise an error in godot script
	assert(true == false, "Must be defined by child class")

func still_attacking(attack_rate) -> bool:
	if (Time.get_ticks_msec() - last_attack_time) < (attack_rate * 1000):
		return true
	return false
