extends Node

@onready var parent = get_parent()
@onready var targeted_timer = $TargetedTimer

func _ready():
	targeted_timer.start()

func _physics_process(_delta):
	if parent.is_targeted:
		return
	parent.is_targeted = true

func remove_status():
	parent.is_targeted = false
	queue_free()
