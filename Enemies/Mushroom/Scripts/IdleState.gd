extends MushroomState

@export var timer := 6.0
@export var interval_min := 2.0
@export var interval_max := 6.0

func _enter_state() -> void:
	super._enter_state()
	_animation_handler("Idle")

func _process(delta: float) -> void:
	_timer_handler()
	timer -= delta

func _physics_process(delta: float) -> void:
	_apply_gravity_handler()
	mushroom.velocity = Vector2.ZERO
	mushroom.move_and_slide()

func _reset_timer_handler() -> void:
	timer = randf_range(interval_min, interval_max)
	get_parent().is_waiting = false

func _timer_handler() -> void:
	if not timer <= 0:
		return
	
	_reset_timer_handler()
