extends Weapon

@export var attack_rate = 1
@export var damage  = 1000
@onready var hitbox = $Hitbox
@onready var hide_timer = $HideTimer


func try_attack():
	if still_attacking((attack_rate)) && !Input.is_action_pressed("aim"):
		return
	visible = true
	last_attack_time = Time.get_ticks_msec()
	play_animation()
	var enemies = hitbox.get_overlapping_bodies()
	for enemy in enemies:
		if enemy.name != "Player" && enemy.has_method("take_damage"):
			enemy.take_damage(5)
	hide_timer.start()