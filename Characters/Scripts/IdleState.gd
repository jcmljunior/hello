class_name IdleState extends CharacterState

@export var friction := .25

func _process(_delta: float) -> void:
	_character_apply_gravity_handler()

func _physics_process(_delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, 0.0, friction)
	player.move_and_slide()
