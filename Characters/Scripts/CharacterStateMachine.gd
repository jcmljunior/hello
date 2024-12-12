class_name CharacterStateMachine extends StateMachine

@onready var player: CharacterBody2D = owner

var input_direction

func _change_state(state: String) -> void:
	_change_state_handler(get_node_or_null(state))


func _has_fall_handler() -> bool:
	if player.velocity.y < 0:
		return false
		
	if player.is_on_floor():
		return false
	
	return true
	
func _has_idle_handler() -> bool:
	if input_direction:
		return false
		
	if not player.is_on_floor():
		return false
		
	if Input.is_action_pressed("jump"):
		return false
	
	return true
	
func _has_run_handler() -> bool:
	if not input_direction:
		return false
		
	if not player.is_on_floor():
		return false

	if Input.is_action_pressed("jump"):
		return false
	
	return true


func _has_jump_handler() -> bool:
	if player.velocity.y > 0:
		return false
	
	return true

func _process(_delta: float) -> void:
	input_direction = Input.get_axis("move_left", "move_right")
	
	if _has_idle_handler():
		_change_state("Idle")
		
	elif _has_run_handler():
		_change_state("Run")
	
	elif _has_jump_handler():
		_change_state("Jump")
		
	elif _has_fall_handler():
		_change_state("Fall")
	

func _character_hit_handler() -> void:
	_change_state_handler(get_node_or_null("Hit"))
