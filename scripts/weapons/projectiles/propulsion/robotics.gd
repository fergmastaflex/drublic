extends PropulsionProjectile

# NOTE: This comes with a magnet component built into the scene

func _init():
	super()
	damage = 25.0

func give_damage(body):
	if body is Enemy && !body.ally && !player.follower:
		player.follower = body
		body.ally = player
		body.is_defective = true
		queue_free()
	else:
		super(body)
