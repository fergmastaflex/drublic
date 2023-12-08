extends Area3D

const AREA_DAMAGE = 5
const AREA_HEAL_AMOUNT = 2

func _ready():
	set_as_top_level(true)

func try_heal_or_hurt():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			body.heal(AREA_HEAL_AMOUNT)
		elif body.is_in_group("enemies"):
			body.take_damage(AREA_DAMAGE)

func destroy():
	queue_free()