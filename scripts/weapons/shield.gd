extends Weapon

@onready var pistol = $Pistol
@onready var aura = $Aura
@onready var aura_collider = $Aura/Aura/AuraCollider
@onready var aura_mesh = $Aura/Aura/AuraMesh
var aura_scene : PackedScene

func _process(_delta):
	set_ammo_scene()
	
	if Input.is_action_pressed("aim"):
		aura.visible = true
		aura.monitoring = true
	else:
		aura.visible = true
		aura.monitoring = true

func try_attack():
	pistol.try_attack()

func weapon_type():
	return Global.WeaponTypes.SUPPRESSION

func set_ammo_scene():
	super()
	if aura_scene != ammo_scene:
	aura_scene = ammo_scene
	ammo_scene.
	aura_collider.radius = 