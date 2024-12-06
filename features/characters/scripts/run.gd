extends CharacterState

func enter_state() -> void:
	super.enter_state()
	_player_sprite_direction_handler()

func _physics_process(delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, player.direction * player.move_speed, player.friction)
