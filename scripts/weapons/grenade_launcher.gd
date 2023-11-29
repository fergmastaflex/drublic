extends Weapon

func _process(_delta):
	set_ammo_scene()
	if Input.is_action_just_pressed("attack"):
		try_attack()

func _init():
	base_weapon_type = Global.WeaponTypes.PROPULSION