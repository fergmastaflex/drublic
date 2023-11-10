extends Area3D
class_name Scrap

@export var scrap_amount : int = 1
var scrap_type

const SCRAP_TYPES = ["ballistics","propulsion","suppression","robotics","optics"]

func _ready():
	scrap_amount = randi_range(10,20)
	scrap_type = SCRAP_TYPES[randi() % SCRAP_TYPES.size()]
	add_to_group("scrap")
	
func _on_body_entered(body):
	# I don't love how vague this is, but if this is the best way...
	# I suppose the first condition acts as a guard, but still
	if body.name == "Drone" || body.name == "Player":
		body.give_scrap(scrap_amount, scrap_type)
		queue_free()
