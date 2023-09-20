extends Node

@export_range(0, 25) var speed: float = 3

@export var character_body: CharacterBody3D
@export var player_camera: Camera3D


func _physics_process(_delta: float) -> void:
	# get input vector and convert to vector3
	var input_vector: Vector2 = Input.get_vector("left", "right", "up", "down")
	var move_vector: Vector3 = Vector3(input_vector.x, 0, input_vector.y)
	# player moves relative to where they're facing
	var direction: Vector3 = (character_body.transform.basis * move_vector).normalized()
	
	# if not (0,0,0)
	if direction:
		character_body.velocity.x = direction.x * speed
		character_body.velocity.z = direction.z * speed
	# gradually bring the player to a halt
	else:
		character_body.velocity.x = move_toward(character_body.velocity.x, 0, speed)
		character_body.velocity.z = move_toward(character_body.velocity.z, 0, speed)
	
	
	character_body.move_and_slide()
