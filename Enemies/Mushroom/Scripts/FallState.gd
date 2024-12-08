extends MushroomState


func _process(_delta: float) -> void:
	_apply_gravity_handler()
	

func _physics_process(_delta: float) -> void:
	mushroom.move_and_slide()
