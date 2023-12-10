extends Node3D
class_name Holster

@export var current_weapon : Weapon

@onready var grenade_launcher = $GrenadeLauncher
@onready var sniper = $Sniper
@onready var shield = $Shield
@onready var turret = $Turret
@onready var sprayer = $Sprayer
	
func set_current_weapon(type):
	match type:
		Global.WeaponTypes.BIOTICS:
			current_weapon = sprayer
		Global.WeaponTypes.PROPULSION:
			current_weapon = grenade_launcher
		Global.WeaponTypes.OPTICS:
			current_weapon = sniper
		Global.WeaponTypes.ROBOTICS:
			current_weapon = turret
		Global.WeaponTypes.SUPPRESSION:
			current_weapon = shield

func empty():
	if current_weapon:
		return false
	return true

func has_base_weapon():
	return current_weapon && current_weapon.weapon_mod
