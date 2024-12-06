extends CharacterState

@onready var audio_jump: AudioStreamPlayer2D = $"../../jump"


func enter_state() -> void:
	super.enter_state()
	_player_jump_handler()


func _player_jump_handler() -> void:
	player.velocity.y = player.jump_speed
	audio_jump.play()
