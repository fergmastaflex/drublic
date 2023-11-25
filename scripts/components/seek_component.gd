extends Node
func run(target, position, max_speed):
	var force : Vector3
	var desired : Vector3 = target - position
	desired = desired.normalized()
	force = desired * max_speed
	return force
