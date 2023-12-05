extends PropulsionProjectile


@onready var healing_area_scene = preload("res://scenes/weapons/projectiles/propulsion/effects/healing_area.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	damage = 5.0

func give_damage(_body):
	var healing_area = healing_area_scene.instantiate()
	main_scene.add_child(healing_area)
	healing_area.position = position

	var bodies = $DamageRadius.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies") && body.has_method("take_damage"):
			body.take_damage(damage)
	
	queue_free()
