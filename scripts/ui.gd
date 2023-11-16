extends Control

@onready var healthBar = get_node("HealthBar")
@onready var scrap_counter = $ScrapCounter
@onready var powerup_alert = $PowerupAlert
@onready var enemy_scene = preload("res://scenes/enemy.tscn")
@onready var propulsion_count = $PropulsionCount
@onready var robotics_count = $RoboticsCount
@onready var suppression_count = $SuppressionCount
@onready var optics_count = $OpticsCount
@onready var ballistics_count = $BallisticsCount


func update_health_bar(currentHealth, maxHealth):
	healthBar.value = (100 / maxHealth) * currentHealth
	
func update_scrap_count(current_scrap):
	scrap_counter.text = str("Total Scrap: ", current_scrap)

func update_type_total(type_totals):
	for type in type_totals:
		get(str(type,"_count")).text = str(type,': ',type_totals[type])

func show_fabricate_message():
	powerup_alert.text = "Press [F] to fabricate!"

func _on_mob_timer_timeout():
	if get_tree().get_nodes_in_group("enemies").size() < 3:
		var enemy = enemy_scene.instantiate() # Replace with function body.
		enemy.position = Vector3(0.0,1.0,0.0)
		add_child(enemy)

func remove_fabricate_message():
	powerup_alert.text = ""
