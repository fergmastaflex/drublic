extends PropulsionProjectile

@onready var magnet_radius = $MagnetRadius
@onready var velocity_component = $VelocityComponentRb
@onready var seek_component = $SeekComponent

func _init():
	super()
	damage = 25.0

func _physics_process(_delta):
	var enemy
	var targets = magnet_radius.get_overlapping_bodies()
	if targets:
		for target in targets:
			if target.is_in_group("enemies") && target != player.follower:
				enemy = target
	if enemy:
		velocity_component.apply_force(self, seek_component.run(enemy.global_position, global_position, velocity_component.max_force))

func give_damage(body):
	if body is Enemy && !body.ally && !player.follower:
		player.follower = body
		body.ally = player
		body.is_defective = true
		queue_free()
	else:
		super(body)
