class_name CharacterStateMachine extends StateMachine

@onready var player: CharacterBody2D = owner
@onready var ground_sensor: RayCast2D = owner.get_node_or_null("GroundSensor")

var input_direction

func _change_state(state: String) -> void:
	_change_state_handler(get_node_or_null(state))


func _has_fall_handler() -> bool:
	if player.velocity.y < 0:
		return false
		
	if ground_sensor.is_colliding():
		return false
	
	return true
	
func _has_idle_handler() -> bool:
	if input_direction:
		return false
		
	if not ground_sensor.is_colliding():
		return false
		
	if Input.is_action_pressed("jump"):
		return false
	
	return true
	
func _has_run_handler() -> bool:
	if not input_direction:
		return false
		
	if not ground_sensor.is_colliding():
		return false
		
	if Input.is_action_pressed("jump"):
		return false
	
	return true


func _has_jump_handler() -> bool:
	if not Input.is_action_pressed("jump"):
		return false
	
	if player.velocity.y > 0:
		return false
		
	if not ground_sensor.is_colliding():
		return false
	
	return true

func _process(delta: float) -> void:
	input_direction = Input.get_axis("move_left", "move_right")
	
	if _has_jump_handler():
		_change_state("Jump")
		
	elif _has_fall_handler():
		_change_state("Fall")
		
	elif _has_idle_handler():
		_change_state("Idle")
		
	elif _has_run_handler():
		_change_state("Run")

func _character_hit_handler() -> void:
	_change_state_handler(get_node_or_null("Hit"))
