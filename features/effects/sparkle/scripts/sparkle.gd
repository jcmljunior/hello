extends Node2D

func _on_animation_finished(anim_name: StringName) -> void:
	if not anim_name == "idle":
		return
	
	queue_free()
