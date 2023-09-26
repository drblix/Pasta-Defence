extends Node


func _on_meatball_body_entered(other_body: Node):
	#await get_tree().create_timer(2).timeout
	get_parent().queue_free()
	#if other_body.is_in_group("enemy"):
		# reduce hp of enemy or something
	#	get_parent().queue_free()
