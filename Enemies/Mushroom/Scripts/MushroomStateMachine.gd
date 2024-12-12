class_name MushroomStateMachine extends StateMachine

@onready var mushroom : CharacterBody2D = owner
@onready var ground_sensor : RayCast2D = get_parent().get_node_or_null("GroundSensor")
@onready var player_sensor : RayCast2D = get_parent().get_node_or_null("PlayerSensor")


func _has_idle_handler() -> bool:
	# Não pode ficar ocioso se não estiver aguardando.
	if not get_node("Patrol").is_waiting:
		return false
	
	# Não pode ficar ocioso sem superficie.
	if not ground_sensor.is_colliding():
		return false
	
	# Não pode ficar ocioso, se o jogador estiver na área de detecção.
	if mushroom.get("player"):
		return false
		
	#if get_previous_state().name == "Chasing" and get_node("Patrol").is_waiting:
		#get_node("Idle")._reset_timer_handler()
		#return false

	
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
		mushroom.set("player", player_sensor.get_collider())
		return false
	
	# Não pode patrulhar sem pontos de destino.
	if not get_node("Patrol").patrol_points.size():
		return false
	
	# Não pode patrulhar se estiver ocioso.
	if get_node("Patrol").is_waiting:
		return false
	
	# Não pode patrulhar com uma referência do jogador.
	if mushroom.get("player"):
		return false
		
	
	return true

func _has_chasing_handler() -> bool:
	# Não pode perseguir o jogador se ele não estiver ao chão.
	if not ground_sensor.is_colliding():
		return false
	
	# Não pode perseguir o jogador se ele não estiver na área de detecção.
	if not player_sensor.is_colliding():
		# Elimina a referência do jogador para finalizar o estado de perseguição.
		mushroom.set("player", null)
		
		return false
	
	# Não pode perseguir o jogador sem sua referência.
	if not mushroom.get("player"):
		return false

	
	return true

func _process(delta: float) -> void:
	if _has_fall_handler():
		_change_state_handler(get_node_or_null("Fall"))
	
	elif _has_patrol_handler():
		_change_state_handler(get_node_or_null("Patrol"))
		
	elif _has_chasing_handler():
		_change_state_handler(get_node_or_null("Chasing"))
		
	elif _has_idle_handler():
		_change_state_handler(get_node_or_null("Idle"))
