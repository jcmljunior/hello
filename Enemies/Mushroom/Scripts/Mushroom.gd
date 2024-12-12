extends CharacterBody2D

var player: CharacterBody2D

@onready var state_machine : MushroomStateMachine = get_node_or_null("StateMachine")


func _ready() -> void:
	state_machine.connect("current_state_changed", _on_current_state_changed)

func _on_current_state_changed(state: State) -> void:
	if not state:
		return
		
	print("O estado do inimigo foi modificado para: %s" % [state.name])
