extends MushroomState

func _physics_process(_delta: float) -> void:
	_apply_gravity_handler()
	mushroom.move_and_slide()
