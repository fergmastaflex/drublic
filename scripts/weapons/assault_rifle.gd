extends Weapon

@onready var attack_ray_cast = $AttackRayCast
var damage = 1

# The input check is different for auto fire
func _process(_delta):
	if Input.is_action_pressed("attack"):
		try_attack()

func weapon_type():
	return Global.WeaponTypes.BIOTICS
