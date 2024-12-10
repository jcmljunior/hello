extends StateMachine

@onready var state_machine: StateMachine = owner.get_node_or_null("StateMachine")
@onready var dissolve := state_machine.get_node_or_null("Dissolve")

func _process(delta: float) -> void:
	if not dissolve:
		return
		
	if dissolve.get("current_frame") >= dissolve.get("FRAME_COUNT"):
		return _change_state_handler(get_node_or_null("ClearMemory"))
		
	_change_state_handler(get_node_or_null("Dissolve"))
