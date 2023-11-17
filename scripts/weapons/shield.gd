extends Weapon

@onready var attack_ray_cast = $AttackRayCast
@onready var pistol = $Pistol
var attack_rate = 0.1
var damage = 1

# # The input check is different for auto fire
# func _process(_delta):

func try_attack():
	pistol.try_attack()

func weapon_type():
	return Holster.WeaponTypes.SUPPRESSION
