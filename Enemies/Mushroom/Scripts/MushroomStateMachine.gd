class_name MushroomStateMachine extends StateMachine

@onready var mushroom : CharacterBody2D = owner
@onready var collider : RayCast2D = get_parent().get_node_or_null("RayCast2D2")

func _change_state(state: String) -> void:
	_change_state_handler(get_node_or_null(state))

func _has_fall_handler() -> bool:
	if mushroom.velocity.y > 0:
		return false
		
	if collider.is_colliding():
		return false
	
	return true

func _has_patrol_handler() -> bool:
	if not collider.is_colliding():
		return false
		
	if mushroom.get("player"):
		return false
	
	return true

func _has_chasing_handler() -> bool:
	if not mushroom.get("player"):
		return false
	
	return true

func _process(delta: float) -> void:
	if _has_fall_handler():
		_change_state("Fall")
	
	elif _has_patrol_handler():
		_change_state("Patrol")
		
	elif _has_chasing_handler():
		_change_state("Chasing")
