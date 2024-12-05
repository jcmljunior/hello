extends CharacterState

func _physics_process(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, 0.0, player.friction)
