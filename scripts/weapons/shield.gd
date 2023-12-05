extends Weapon

@onready var pistol = $Pistol

func try_attack():
	pistol.try_attack()

func weapon_type():
	return Global.WeaponTypes.SUPPRESSION
