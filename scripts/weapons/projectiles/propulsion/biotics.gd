extends PropulsionProjectile

@onready var healing_area_scene = preload("res://scenes/weapons/projectiles/effects/healing_area.tscn")

# Biotics grenades are basically smoke grenades
func emit_explosion():
	pass

# Called when the node enters the scene tree for the first time.
func _init():
	damage = 20.0
	bullet_velocity = 15

func give_damage(body):
	var healing_area = healing_area_scene.instantiate()
	get_window().add_child.call_deferred(healing_area)
	healing_area.global_position = global_position

	super(body)
