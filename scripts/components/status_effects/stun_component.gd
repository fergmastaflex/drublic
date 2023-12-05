extends Node


@onready var parent = get_parent()
@onready var stun_timer = $StunTimer

func _ready():
	stun_timer.start()

func _physics_process(_delta):
	if parent.is_stunned:
		return
	parent.is_stunned = true

func remove_status():
	parent.is_stunned = false
	queue_free()