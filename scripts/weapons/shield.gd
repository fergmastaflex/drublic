extends Weapon

@onready var pistol = $Pistol
var aura

func _process(_delta):
	set_ammo_scene()

func try_attack():
	pistol.try_attack()

func _init():
	base_weapon_type = Global.WeaponTypes.SUPPRESSION

func set_ammo_scene():
	super()
	var new_ammo_scene = ammo_scene.instantiate()
	if !aura || aura.name != new_ammo_scene.name:
		if is_instance_valid(aura):
			aura.queue_free()
		aura = new_ammo_scene
		add_child(aura)
		aura.global_transform = marker.global_transform
	else:
		new_ammo_scene.queue_free()
