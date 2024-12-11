extends MushroomState

var timer := 6.0

func _enter_state() -> void:
	super._enter_state()
	_animation_handler("Idle")

func _physics_process(delta: float) -> void:
	_apply_gravity_handler()
	timer -= delta
	
	if timer <= 0:
		timer = randf_range(2.0, 5.0)
		get_parent().get_node_or_null("Patrol").is_waiting = false
	
	mushroom.move_and_slide()
