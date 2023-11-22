extends Node
func run(target : Vector3, position : Vector3, max_speed : float, arrive_threshold : float) -> Vector3:
	var force : Vector3
	var desired : Vector3 = target - position
	var distance : float = desired.length()
	desired = desired.normalized()
	if distance < arrive_threshold:
		force = (desired * distance).limit_length(max_speed)
	else:
		force = desired * max_speed
	return force