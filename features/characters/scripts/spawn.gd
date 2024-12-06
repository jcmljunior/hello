extends CharacterState

@onready var timer_spawn: Timer = %timer_spawn
@onready var audio_spawn: AudioStreamPlayer2D = $"../../spawn"

func enter_state() -> void:
	super.enter_state()
	
	timer_spawn.start()
	audio_spawn.play()
