class_name MushroomStateMachine extends StateMachine

@onready var mushroom : CharacterBody2D = owner
@onready var ground_sensor : RayCast2D = get_parent().get_node_or_null("GroundSensor")
@onready var player_sensor : RayCast2D = get_parent().get_node_or_null("PlayerSensor")

@export var is_waiting := false


func are_you_falling() -> bool:
	if ground_sensor.is_colliding():
		return false
	
	return true
	
func are_you_idle() -> bool:
	if not ground_sensor.is_colliding():
		return false
		
	if player_sensor.is_colliding():
		mushroom.set("player", player_sensor.get_collider())
		return false
		
	if not is_waiting:
		return false
	
	return true

func are_you_patrolling() -> bool:
	if not ground_sensor.is_colliding():
		return false
		
	if player_sensor.is_colliding():
		mushroom.set("player", player_sensor.get_collider())
		return false
		
	if is_waiting:
		return false
		
	return true

func are_you_chasing() -> bool:
	if not ground_sensor.is_colliding():
		return false
		
	if not player_sensor.is_colliding():
		mushroom.set("player", null)
		return false
		
	if is_waiting:
		get_node("Idle")._reset_timer_handler()
		
	return true

func _process(_delta: float) -> void:
	if are_you_falling():
		_change_state_handler(get_node_or_null("Fall"))
		
	elif are_you_idle():
		_change_state_handler(get_node_or_null("Idle"))
		
	elif are_you_patrolling():
		_change_state_handler(get_node_or_null("Patrol"))
		
	elif are_you_chasing():
		_change_state_handler(get_node_or_null("Chasing"))
