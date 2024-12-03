extends PlayerState

func enter_state() -> void:
	super.enter_state()
	print("idle state...")

func _process(delta: float) -> void:
	super._process(delta)
	
	if get_input_direction_x():
		return state_machine._change_state_handler(get_parent().find_child("running"))

func _physics_process(delta: float) -> void:
	_gravity_handler(delta)
	get_player().move_and_slide()
