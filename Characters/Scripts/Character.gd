extends CharacterBody2D

@onready var state_machine : CharacterStateMachine = get_node_or_null("StateMachine")

func _ready() -> void:
	state_machine.connect("current_state_changed", _on_current_state_changed)

func _on_current_state_changed(state: State) -> void:
	if not state:
		return
		
	print("O estado jogador foi modificado para: %s" % [state.name])
