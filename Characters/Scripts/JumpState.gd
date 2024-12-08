extends CharacterState

@export var jump_force := -400.0

func _enter_state() -> void:
	super._enter_state()
	
	player.velocity.y = jump_force

func _process(_delta: float) -> void:
	_character_apply_gravity_handler()

func _physics_process(delta: float) -> void:
	player.move_and_slide()
