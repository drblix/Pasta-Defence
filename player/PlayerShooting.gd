extends Node

@export var player_camera: Node

var meatball_obj = preload("res://meatball/meatball.tscn")
var world_node: Node

func _ready():
	world_node = get_parent().get_parent().get_parent()

func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		var new_meatball: RigidBody3D = meatball_obj.instantiate()
		world_node.add_child(new_meatball)
		print(new_meatball.transform.basis.z)
