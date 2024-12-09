class_name MushroomStateMachine extends StateMachine

@onready var mushroom : CharacterBody2D = owner
@onready var ground_sensor : RayCast2D = get_parent().get_node_or_null("GroundSensor")
@onready var player_sensor : RayCast2D = get_parent().get_node_or_null("PlayerSensor")

func _change_state(state: String) -> void:
	_change_state_handler(get_node_or_null(state))

func _has_idle_handler() -> bool:
	if not ground_sensor.is_colliding():
		return false
		
	if not get_node("Patrol").is_waiting:
		return false
	
	if mushroom.velocity:
		return false
	
	return true

func _has_fall_handler() -> bool:
	if ground_sensor.is_colliding():
		return false
	
	if mushroom.velocity.y > 0:
		return false
	
	return true

func _has_patrol_handler() -> bool:
	if not ground_sensor.is_colliding():
		return false
		
	if player_sensor.is_colliding():
		return false
		
	if not get_node("Patrol").patrol_points.size():
		return false
		
	if get_node("Patrol").is_waiting:
		return false
	
	return true

func _has_chasing_handler() -> bool:
	if not ground_sensor.is_colliding():
		return false
	
	if not player_sensor.is_colliding():
		return false
		
	if get_node("Patrol").is_waiting:
		return false
	
	return true

func _player_collider_handler() -> void:
	if not player_sensor.get_collider():
		mushroom.set("player", null)
		return
		
	if not player_sensor.get_collider() is Area2D:
		return
		
	if not player_sensor.get_collider().get_parent() is CharacterBody2D:
		return
		
	mushroom.set("player", player_sensor.get_collider().get_parent())

func _process(delta: float) -> void:
	_player_collider_handler()
	
	if _has_fall_handler():
		_change_state("Fall")
	
	elif _has_patrol_handler():
		_change_state("Patrol")
		
	elif _has_chasing_handler():
		_change_state("Chasing")
		
	elif _has_idle_handler():
		_change_state("Idle")
