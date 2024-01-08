extends Area3D

var activatable : bool
@onready var label = $Label3D
@onready var enemy_scene = preload("res://scenes/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body:Node3D):
	if body.is_in_group("players"):
		activatable = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if activatable:
		label.visible = true
		if Input.is_action_just_pressed("activate"):
			var enemy = enemy_scene.instantiate() # Replace with function body.
			enemy.global_position = Vector3(0.0,1.0,0.0)
			get_tree().get_root().add_child.call_deferred(enemy)
	else:
		label.visible = false

func _on_body_exited(body:Node3D):
	if body.is_in_group("players"):
		activatable = false
