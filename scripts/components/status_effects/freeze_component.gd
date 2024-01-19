extends Node

var freeze_stacks = 1

@onready var parent = get_parent()

const SPEED_REDUCTION_INCREMENT = 0.2
const FREEZE_STACK_MAX = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	parent.is_freezing = true

func _process(_delta):
	var reduce_amount = parent.base_movement_speed * (freeze_stacks * SPEED_REDUCTION_INCREMENT)
	parent.current_movement_speed = parent.base_movement_speed - reduce_amount

func add_stack():
	if freeze_stacks != FREEZE_STACK_MAX:
		freeze_stacks += 1

func remove_stack():
	if freeze_stacks > 0:
		freeze_stacks -= 1
	else:
		queue_free()
