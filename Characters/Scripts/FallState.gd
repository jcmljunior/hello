class_name FallState  extends CharacterState

func _process(_delta: float) -> void:
	_character_apply_gravity_handler()

func _physics_process(delta: float) -> void:
	player.move_and_slide()
