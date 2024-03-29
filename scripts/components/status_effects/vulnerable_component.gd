extends Node

@onready var parent = get_parent()
@onready var vulnerable_timer = $VulnerableTimer

func _ready():
	vulnerable_timer.start()

func _physics_process(_delta):
	if parent.is_vulnerable:
		return
	parent.is_vulnerable = true

func remove_status():
	parent.is_vulnerable = false
	queue_free()