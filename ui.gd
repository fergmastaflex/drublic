extends Control

@onready var healthBar = get_node("HealthBar")
@onready var scrapBar = get_node("ScrapBar")
@onready var powerupAlert = get_node("PowerupAlert")
@onready var powerupTimer = get_node("PowerupTimer")
@onready var enemy_scene = preload("res://enemy.tscn")

func update_health_bar(currentHealth, maxHealth):
	healthBar.value = (100 / maxHealth) * currentHealth
	
func update_scrap_bar(currentScrap, maxScrap):
	scrapBar.value = (100 / maxScrap) * currentScrap
	
func update_powerup_text(powerup):
	powerupAlert.text = str(powerup, " added!")
	powerupTimer.start()
	
# func _on_mob_timer_timeout():
# 	if get_tree().get_nodes_in_group("enemies").size() < 3:
# 		var enemy = enemy_scene.instantiate() # Replace with function body.
# 		enemy.position = Vector3(0.0,1.0,0.0)
# 		add_child(enemy)

func _on_powerup_timer_timeout():
	powerupAlert.text = ""
