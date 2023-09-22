extends Node

@export_range(0, 25) var move_speed: float = 3
@export_range(0, 10) var jump_power: float = 5

@export var character_body: CharacterBody3D
@export var player_camera: Camera3D

@onready var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta: float) -> void:
	# get input vector and convert to vector3
	var input_vector: Vector2 = Input.get_vector("left", "right", "up", "down")
	var move_vector: Vector3 = Vector3(input_vector.x, 0, input_vector.y)
	# player moves relative to where they're facing
	var direction: Vector3 = (character_body.transform.basis * move_vector).normalized()
	
	# handle player jumping
	if character_body.is_on_floor() and Input.is_action_pressed("jump"):
		character_body.velocity.y = jump_power
	
	# if not (0,0,0)
	if direction:
		character_body.velocity.x = direction.x * move_speed
		character_body.velocity.z = direction.z * move_speed
	# gradually bring the player to a halt
	else:
		character_body.velocity.x = move_toward(character_body.velocity.x, 0, move_speed)
		character_body.velocity.z = move_toward(character_body.velocity.z, 0, move_speed)
	
	# applying constant gravity
	character_body.velocity.y -= delta * gravity
	
	character_body.orthonormalize()
	
	character_body.move_and_slide()
