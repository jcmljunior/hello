extends CharacterState

@export var jump_force := -400.0

func _enter_state() -> void:
	super._enter_state()
	
	player.velocity.y = jump_force

func _physics_process(_delta: float) -> void:
	_apply_gravity_handler()
	player.move_and_slide()
