class_name IdleState extends CharacterState

@export var friction := 3.0

func _physics_process(delta: float) -> void:
	_apply_gravity_handler()
	player.velocity.x = lerp(player.velocity.x, 0.0, friction * delta)
	player.move_and_slide()
