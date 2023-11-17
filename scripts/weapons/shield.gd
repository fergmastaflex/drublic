extends Weapon

@onready var attack_ray_cast = $AttackRayCast
var attack_rate = 0.1
var damage = 1

# The input check is different for auto fire
func _process(_delta):
	pass

func try_attack():
	pass

func weapon_type():
	return Holster.WeaponTypes.SUPPRESSION
