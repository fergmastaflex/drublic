extends Node

@export var max_force : float = 0.0
var velocity : Vector3

func apply_force(body, force):
    velocity = body.linear_velocity
    force = (force - velocity).limit_length(max_force)
    body.apply_force(force)