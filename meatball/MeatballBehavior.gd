extends Node


func _on_meatball_body_entered(other_body: Node):
	if other_body.is_in_group("enemy"):
		# reduce hp of enemy or something
		get_parent().queue_free()
