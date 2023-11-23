extends RigidBody3D
class_name Scrap

@export var scrap_amount : int = 1
@onready var drone_target = $DroneTarget
var scrap_type

func _ready():
	scrap_amount = randi_range(10,20)
	scrap_type = Holster.WeaponTypes.keys()[randi() % Holster.WeaponTypes.size()]
	# scrap_type = Holster.WeaponTypes[random_scrap_type]
	add_to_group("scrap")
	
func _on_body_entered(body):
	if body.name == "Drone" || body.name == "Player":
		body.give_scrap(scrap_amount, scrap_type)
		queue_free()
