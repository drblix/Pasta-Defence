extends Node

@export var meatball_spawn: Area3D
@export var player_camera: Node

@export_range(1, 15) var throw_force: float = 5

var meatball_obj = preload("res://meatball/meatball.tscn")
var world_node: Node

func _ready() -> void:
	world_node = get_parent().get_parent().get_parent()

func _process(_delta) -> void:
	if can_shoot():
		var new_meatball: RigidBody3D = meatball_obj.instantiate()
		world_node.add_child(new_meatball)
		new_meatball.global_position = meatball_spawn.global_position
		
		var forward_vec = -player_camera.get_global_transform().basis.z
		new_meatball.apply_impulse(forward_vec * throw_force)
		print(forward_vec)
		

# if pressing shoot button and spawn node isn't inside other collider
func can_shoot() -> bool:
	return Input.is_action_just_pressed("shoot") and meatball_spawn.get_overlapping_bodies().size() == 0
