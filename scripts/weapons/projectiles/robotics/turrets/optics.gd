extends RoboticsTurret

@onready var optics_aura = $TurretBody/OpticsAura
@onready var magnet_component_scene = preload('res://scenes/components/magnet_component.tscn')

func add_magnet_component(body):
	if (body.is_in_group("player_projectiles") || body is RoboticsProjectile) && !body.has_node(NodePath("MagnetComponent")):
		var magnet_component = magnet_component_scene.instantiate()
		magnet_component.max_force = body.bullet_velocity
		body.add_child(magnet_component)