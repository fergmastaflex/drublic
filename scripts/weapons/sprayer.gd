extends Weapon

# @onready var damage_area = $DamageArea
# @onready var flame_particle = $FlameParticle
var spray

func _process(_delta):
	set_ammo_scene()

	if Input.is_action_pressed("attack"):
		if !spray:
			spray = ammo_scene.instantiate()
			add_child(spray)
			spray.global_transform = marker.global_transform
			spray.particle.emitting = true
		# try_attack()
	else:
		if is_instance_valid(spray):
			spray.queue_free()

func _init():
	base_weapon_type = Global.WeaponTypes.BIOTICS

func try_attack():
	pass

# func try_attack():
# 	if !is_visible_in_tree() || still_attacking():
# 		return
# 	var bodies = damage_area.get_overlapping_bodies()
	
# 	var projectile = ammo_scene.instantiate()

# 	add_child(projectile)
# 	for body in bodies:
# 		if body.is_in_group("enemies") && body.has_method("take_damage"):
# 			body.take_damage(projectile.damage)
