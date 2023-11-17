extends Node3D
class_name Holster

# @export var current_weapon_mod : String
@export var current_weapon : Weapon

@onready var grenade_launcher = $GrenadeLauncher
@onready var sniper = $Sniper
@onready var shield = $Shield
@onready var turret = $Turret
@onready var assault_rifle = $AssaultRifle
@onready var basher = $Basher

# TODO: Put these in some kind of global singleton
enum WeaponTypes { BIOTICS, PROPULSION, OPTICS, ROBOTICS, SUPPRESSION }
	
func set_current_weapon(type):
	match type:
		WeaponTypes.BIOTICS:
			current_weapon = assault_rifle
		WeaponTypes.PROPULSION:
			current_weapon = grenade_launcher
		WeaponTypes.OPTICS:
			current_weapon = sniper
		WeaponTypes.ROBOTICS:
			current_weapon = turret
		WeaponTypes.SUPPRESSION:
			current_weapon = shield

func empty():
	if current_weapon:
		return false
	return true

func has_base_weapon():
	return current_weapon && current_weapon.weapon_mod
