class_name MushroomStateMachine extends StateMachine

func _process(delta: float) -> void:
	if not owner.is_on_floor():
		_change_state_handler(get_node_or_null("Fall"))
		
	elif owner.get("player"):
		_change_state_handler(get_node_or_null("Chasing"))
	
	elif not owner.get("player"):
		_change_state_handler(get_node_or_null("Patrol"))
		
	
