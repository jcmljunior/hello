extends CanvasLayer

@onready var state_machine = get_parent().get_node("state_machine")
@onready var score_label: Label = %score_label
@onready var state_label: Label = %state_label

func _ready() -> void:
	ScoreManager.connect("on_score_changed", _on_score_changed)
	state_machine.connect("on_current_state_changed", _on_current_state_changed)
	
	_on_current_state_changed()


func _on_score_changed() -> void:
	score_label.text = str(ScoreManager.get_score())

func _on_current_state_changed() -> void:
	var current_state = state_machine.get_current_state()
	
	if not current_state:
		return
	
	state_label.text = current_state.name
