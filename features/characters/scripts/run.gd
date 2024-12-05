extends CharacterState

func _physics_process(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, player.direction * player.move_speed, player.friction)
