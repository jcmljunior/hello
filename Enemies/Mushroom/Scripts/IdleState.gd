extends MushroomState

@export var timer := 6.0
@export var interval_min := 2.0
@export var interval_max := 6.0

func _enter_state() -> void:
	super._enter_state()
	_animation_handler("Idle")
	
	# Se o estado anterior for Perseguir, o inimigo ignora o estado ocioso.
	# Durante o estado ocioso, o inimigo detectou o jogador, reiniciando o ciclo de patrulha.
	if get_parent().get_previous_state().name == "Chasing":
		_reset_timer_handler()

func _process(delta: float) -> void:
	_timer_handler()
	timer -= delta

func _physics_process(delta: float) -> void:
	_apply_gravity_handler()
	mushroom.velocity = Vector2.ZERO
	mushroom.move_and_slide()

func _reset_timer_handler() -> void:
	timer = randf_range(interval_min, interval_max)
	get_parent().get_node_or_null("Patrol").is_waiting = false

func _timer_handler() -> void:
	if not timer <= 0:
		return
	
	_reset_timer_handler()
