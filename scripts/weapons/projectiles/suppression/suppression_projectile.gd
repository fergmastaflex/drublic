extends Area3D
class_name SuppressionProjectile

var rng = RandomNumberGenerator.new()
var charge_rate = 1.0
var drain_rate = 0.5
var charge_increment = 10
var drain_increment = 5
var last_drain_time = 0
var last_charge_time = 0
var current_charge = 100
var max_charge = 100
var on_cooldown = false

func _process(_delta):
	handle_aura()

func perform_aura_action():
	pass

func handle_aura():
	if current_charge <= 0:
		current_charge = 0
		visible = false
		on_cooldown = true
	elif on_cooldown && current_charge < max_charge:
		visible = false
	else:
		visible = true
		on_cooldown = false
	
	if is_visible_in_tree():
		if (Time.get_ticks_msec() - last_drain_time) >= (drain_rate * 1000):
			last_drain_time = Time.get_ticks_msec()
			current_charge -= drain_increment
			perform_aura_action()
	else:
		if (Time.get_ticks_msec() - last_charge_time) >= (charge_rate * 1000):
			last_charge_time = Time.get_ticks_msec()
			if current_charge < max_charge:
				current_charge += charge_increment
			if current_charge > max_charge:
				current_charge = max_charge