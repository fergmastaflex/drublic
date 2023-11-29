extends Weapon

@onready var damage_area = $DamageArea
@onready var flame_particle = $FlameParticle

func _process(_delta):
	set_ammo_scene()
	if Input.is_action_pressed("attack"):
		flame_particle.emitting = true
		try_attack()
	else:
		flame_particle.emitting = false

func _init():
	base_weapon_type = Global.WeaponTypes.BIOTICS

func try_attack():
	if !is_visible_in_tree() || still_attacking():
		return
	var bodies = damage_area.get_overlapping_bodies()
	
	var projectile = ammo_scene.instantiate()
	# print(projectile.name)
	add_sibling(projectile)
	for body in bodies:
		if body.is_in_group("enemies") && body.has_method("take_damage"):
			body.take_damage(projectile.damage)
