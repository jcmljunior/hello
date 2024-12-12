class_name MushroomStateMachine extends StateMachine

@onready var mushroom : CharacterBody2D = owner
@onready var ground_sensor : RayCast2D = get_parent().get_node_or_null("GroundSensor")
@onready var player_sensor : RayCast2D = get_parent().get_node_or_null("PlayerSensor")

func _change_state(state: String) -> void:
	_change_state_handler(get_node_or_null(state))

func _has_idle_handler() -> bool:
	# Não pode ficar ocioso se não estiver aguardando.
	if not get_node("Patrol").is_waiting:
		return false
	
	# Não pode ficar ocioso sem superficie.
	if not ground_sensor.is_colliding():
		return false
	
	# Não pode ficar ocioso se estiver se movimentando.
	if mushroom.velocity:
		return false
	
	
	return true

func _has_fall_handler() -> bool:
	# Não pode cair se já estiver no chão.
	if ground_sensor.is_colliding():
		return false
	
	# Não pode cair se estiver subindo durante o pulo.
	if mushroom.velocity.y > 0:
		return false
	
	
	return true

func _has_patrol_handler() -> bool:
	# Não pode patrulhar se o inimigo não estiver na superficie.
	if not ground_sensor.is_colliding():
		return false
	
	# Não pode patrulhar se o jogador estiver na área de detecção.
	if player_sensor.is_colliding():
		return false
	
	# Não pode patrulhar sem pontos de destino.
	if not get_node("Patrol").patrol_points.size():
		return false
	
	# Não pode patrulhar se estiver ocioso.
	if get_node("Patrol").is_waiting:
		return false
	
	
	return true

func _has_chasing_handler() -> bool:
	#if get_node("Patrol").is_waiting:
		#return false
	
	# Não pode perseguir o jogador se ele não estiver ao chão.
	if not ground_sensor.is_colliding():
		return false
	
	# Não pode perseguir o jogador se ele não estiver na área de detecção.
	if not player_sensor.is_colliding():
		return false
	
	
	return true

func _player_collider_handler() -> void:
	if not player_sensor.get_collider():
		mushroom.set("player", null)
		return
		
	if not player_sensor.get_collider() is CharacterBody2D:
		return
		
	mushroom.set("player", player_sensor.get_collider())

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
