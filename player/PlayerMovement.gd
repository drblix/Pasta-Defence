extends Node

@export_range(0, 25) var speed: float = 3

@export var character_body: CharacterBody3D


func _physics_process(_delta: float) -> void:
	var input_vector: Vector2 = Input.get_vector("left", "right", "down", "up")
	var move_vector: Vector3 = Vector3(-input_vector.y, 0, -input_vector.x) * speed
	
	character_body.velocity = move_vector * character_body.transform.basis
	
	character_body.move_and_slide()
