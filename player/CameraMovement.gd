# Handles the movement of the player's camera within the player character node

extends Node

@export var character_body: CharacterBody3D
@export var camera: Camera3D
@export var mouse_sensitivity: float = 3


func _ready():
	print(camera)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_velocity: Vector2 = event.relative * mouse_sensitivity
		character_body.rotate_y(deg_to_rad(-mouse_velocity.x))
