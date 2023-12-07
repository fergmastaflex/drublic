extends PropulsionProjectile


@onready var healing_area_scene = preload("res://scenes/weapons/projectiles/propulsion/effects/healing_area.tscn")

# Biotics grenades are basically smoke grenades
func emit_explosion():
	pass

# Called when the node enters the scene tree for the first time.
func _init():
	damage = 10.0

func give_damage(body):
	var healing_area = healing_area_scene.instantiate()
	add_child(healing_area)
	healing_area.position = position

	super(body)
