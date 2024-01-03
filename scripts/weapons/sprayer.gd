extends Weapon

var spray

func _process(_delta):
	set_ammo_scene()
	
	if is_visible_in_tree() && Input.is_action_pressed("attack"):
		if !spray:
			spray = ammo_scene.instantiate()
			add_child(spray)
			spray.global_transform = marker.global_transform
			spray.particle.emitting = true
	else:
		if is_instance_valid(spray):
			spray.queue_free()

func _init():
	base_weapon_type = Global.WeaponTypes.BIOTICS

func try_attack():
	pass
