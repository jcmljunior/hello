class_name FallState  extends CharacterState

func _physics_process(_delta: float) -> void:
	_apply_gravity_handler()
	player.move_and_slide()
