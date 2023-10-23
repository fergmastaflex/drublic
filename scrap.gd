extends Area3D
class_name Scrap

@export var scrapAmount : int = 1
@onready var scrapType : String = ''

const SCRAP_TYPES = ["propulsion","defense","biotics","optics","electronics"]

func _ready():
	scrapAmount = 25
	scrapType = SCRAP_TYPES[randi() % SCRAP_TYPES.size()]
	
func _on_body_entered(body):
	# I don't love how vague this is, but if this is the best way...
	# I suppose the first condition acts as a guard, but still
	if body.name == "Player" && body.currentScrap < body.MAX_SCRAP:
		body.give_scrap(scrapAmount, scrapType)
		queue_free()
