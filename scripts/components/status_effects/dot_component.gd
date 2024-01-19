extends Node

@onready var parent = get_parent()
@onready var dot_timer = $DotTimer
@onready var healing_area_scene = preload("res://scenes/weapons/projectiles/effects/healing_area.tscn")

var total_damage = 0

const DAMAGE_INCREMENT = 1
const MAX_DAMAGE = 100

func _ready():
	dot_timer.start()
	parent.is_infected = true

func damage_or_heal_parent():
	if total_damage <= MAX_DAMAGE:
		if parent.is_in_group('enemies'):
			parent.take_damage(DAMAGE_INCREMENT)
			total_damage += DAMAGE_INCREMENT
		elif parent is Player:
			parent.heal(DAMAGE_INCREMENT)
			total_damage += DAMAGE_INCREMENT
		else:
			#if it can't take damage or be healed, then it's probably a wall and should be deleted
			queue_free()
	else:
		queue_free()

func spawn_healing_area():
	var healing_area = healing_area_scene.instantiate()
	get_tree().get_root().add_child.call_deferred(healing_area)
	healing_area.global_position = parent.global_position
