# Handles the movement of the player's camera within the player character node

extends Node

@export var character_body: CharacterBody3D
@export var camera: Camera3D

@export var mouse_sensitivity: float = .5
@export var invert_mouse: bool = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# get change in mouse position
		var mouse_velocity: Vector2 = event.relative * mouse_sensitivity
		# y rotation is handled by the character body
		character_body.rotate_y(deg_to_rad(-mouse_velocity.x))
		
		# swap up-down rotation if inverted
		if invert_mouse:
			camera.rotate_x(deg_to_rad(mouse_velocity.y))
		else:
			camera.rotate_x(deg_to_rad(-mouse_velocity.y))
		
		# clamping rotation on x-axis so player can't rotate upside down
		camera.rotation.x = clampf(camera.rotation.x, deg_to_rad(-80), deg_to_rad(80))
	elif event is InputEventKey and event.keycode == KEY_ESCAPE:
		get_tree().quit()
