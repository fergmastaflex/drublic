extends RoboticsTurret

@onready var biotics_aura = $TurretBody/BioticsAura
@onready var dot_component = preload('res://scenes/components/status_effects/dot_component.tscn')

const HEALING_AMOUNT = 5

# TODO: Refactor this silliness
func _ready():
	marker = null

func heal_or_damage():
	var bodies = biotics_aura.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies") && !body.ally:
			body.add_child(dot_component.instantiate())
		elif body is Player:
			body.heal(HEALING_AMOUNT)

# This turret attacks by givings enemies the nanite status effect
func try_attack():
	pass
