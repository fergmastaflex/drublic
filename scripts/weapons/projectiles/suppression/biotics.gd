extends Area3D

var rng = RandomNumberGenerator.new()
var status_effect_chance = 5.0
var status_effect_scene = load('res://scenes/components/status_effects/dot_component.tscn')
var heal_amount = 6.0
var charge_rate = 1.0
var drain_rate = 0.5
var charge_increment = 10
var drain_increment = 5
var last_drain_time = 0
var last_charge_time = 0

var on_cooldown = false
@onready var shield = get_parent()
@onready var aura_timer = $AuraTimer
@onready var drain_timer = $DrainTimer
@onready var charge_timer = $ChargeTimer
@onready var aura_mesh = $AuraMesh

var current_charge = 100
var max_charge = 100

func _process(_delta):
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
			heal_or_hurt()
	else:
		if (Time.get_ticks_msec() - last_charge_time) >= (charge_rate * 1000):
			last_charge_time = Time.get_ticks_msec()
			if current_charge < max_charge:
				current_charge += charge_increment
			if current_charge > max_charge:
				current_charge = max_charge

func heal_or_hurt():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies") && !body.ally:
			try_status_effect(body)
		elif body.has_method('heal'):
			body.heal(heal_amount)

func try_status_effect(body):
	var random_number = rng.randf_range(0.0, 100.0)
	var status_effect = status_effect_scene.instantiate()
	if random_number <= status_effect_chance && !body.has_node(NodePath(status_effect.name)):
		body.add_child(status_effect)
	else:
		status_effect.queue_free()
