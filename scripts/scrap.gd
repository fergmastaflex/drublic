extends Area3D
class_name Scrap

@export var scrapAmount : int = 1
var scrapType

const SCRAP_TYPES = ["ballistics","propulsion","suppression","robotics","optics"]

func _ready():
	scrapAmount = randi_range(1,3)
	scrapType = SCRAP_TYPES[randi() % SCRAP_TYPES.size()]
	
func _on_body_entered(body):
	# I don't love how vague this is, but if this is the best way...
	# I suppose the first condition acts as a guard, but still
	if body.name == "Player":
		body.give_scrap(scrapAmount, scrapType)
		queue_free()
