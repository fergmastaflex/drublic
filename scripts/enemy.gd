extends CharacterBody3D
class_name Enemy

@export var is_stunned = false
@export var is_targeted = false
@export var is_defective = false
@export var is_volatile = false
@export var is_freezing = false
@export var is_infected = false
@export var ally : Node3D

var rng = RandomNumberGenerator.new()
var current_hp : float = rng.randi_range(20, 50)
var attack_range : float = 1.5
var attack_rate : float = 1.0
var damage: int = 5
var target
var current_movement_speed = 5.0
var base_movement_speed = 5.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var scrap_scene = preload("res://scenes/scrap.tscn")
@onready var stun_label = $StunLabel
@onready var targeted_label = $TargetedLabel
@onready var defective_label = $DefectiveLabel
@onready var volatile_label = $VolatileLabel
@onready var freeze_label = $FreezeLabel
@onready var infected_label = $InfectedLabel

func _ready():
	add_to_group("enemies")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	var enemies = get_tree().get_nodes_in_group("enemies")
	var players = get_tree().get_nodes_in_group("players")

	if ally:
		if enemies:
			for enemy in enemies:
				if enemy.is_defective:
					continue
				else:
					target = enemy
		else:
			target = ally
	else:
		target = players[0]

		if is_stunned:
			stun_label.visible = true
			return
		else:
			stun_label.visible = false
		
		if is_volatile:
			volatile_label.visible = true
		else:
			volatile_label.visible = false
	
		if is_targeted:
			targeted_label.visible = true
		else:
			targeted_label.visible = false
		
		if is_defective:
			defective_label.visible = true
		else:
			defective_label.visible = false

		if is_infected:
			infected_label.visible = true
		else:
			infected_label.visible = false
	
		if is_freezing:
			var freeze_component = get_node('freeze_component')
			freeze_label.visible = true
			freeze_label.text = str("Freezing X ", freeze_component.freeze_stacks)

	if is_instance_valid(target) && position.distance_to(target.position) > attack_range:
		var dir = (target.position - position).normalized()
		velocity.x = dir.x * current_movement_speed
		velocity.y = 0
		velocity.z = dir.z * current_movement_speed

	move_and_slide()

func _on_timer_timeout():
	if is_instance_valid(target):
		if position.distance_to(target.position) <= attack_range:
			if is_defective && target is Player:
				return
			target.take_damage(damage)
	
func take_damage(damage_to_take, crit_chance = 0.0):
	var crit_check = rng.randf_range(0.0, 100.0)
	if is_targeted:
		crit_chance += 25.0

	if is_stunned:
		damage_to_take *= 1.2
		
	if crit_check < crit_chance:
		damage_to_take *= 1.5

	current_hp -= damage_to_take

	if current_hp <= 0:
		die()

func heal(damage_to_heal):
	current_hp += damage_to_heal

func die():
	#drop between 1 and 3 scrap
	for i in rng.randi_range(1,3):
		var scrap = scrap_scene.instantiate()
		add_sibling(scrap)
		scrap.position = position
		scrap.position.x += i
	queue_free()
