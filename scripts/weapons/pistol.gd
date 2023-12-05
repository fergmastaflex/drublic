extends Weapon

@onready var attack_ray_cast = $AttackRayCast
var damage = 1

const PISTOL_PROJECTILE_PATH = "res://scenes/weapons/projectiles/suppression/pistol_base.tscn"

func _ready():
	ammo_scene = load(PISTOL_PROJECTILE_PATH)

func weapon_type():
	return Global.WeaponTypes.ROBOTICS

func set_ammo_type():
	pass