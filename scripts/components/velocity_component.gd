extends Node

@export var max_speed : float = 0.0
@export var max_force : float = 0.0
@export var mass : float = 0.0
@export var arrive_threshhold : float = 0.0

var velocity : Vector3
var acceleration : Vector3

func apply_force(force):
	force = (force - velocity).limit_length(max_force)
	acceleration = force/mass
	velocity += acceleration
	
func move(body):
	body.velocity = velocity
	body.move_and_slide()