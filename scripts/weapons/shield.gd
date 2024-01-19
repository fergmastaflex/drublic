extends Weapon

@onready var pistol = $Pistol
var aura

func _process(_delta):
	set_ammo_scene()
	
	if is_visible_in_tree() && Input.is_action_pressed("aim"):
		if !aura:
			aura = ammo_scene.instantiate()
			add_child(aura)
			aura.global_transform = marker.global_transform
	else:
		if is_instance_valid(aura):
			aura.queue_free()

func try_attack():
	pistol.try_attack()

func _init():
	base_weapon_type = Global.WeaponTypes.SUPPRESSION
