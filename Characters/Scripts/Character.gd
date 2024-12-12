@tool
extends CharacterBody2D

@onready var state_machine : CharacterStateMachine = get_node_or_null("StateMachine")
@onready var show_state: HBoxContainer = %ShowState
@onready var show_fps: HBoxContainer = %ShowFPS


func _ready() -> void:
	if Engine.is_editor_hint():
		get_node("HUD").set_visible(false)
	else:
		get_node("HUD").set_visible(true)
	
	state_machine.connect("current_state_changed", _on_current_state_changed)

func _on_current_state_changed(state: State) -> void:
	if not state:
		return
	
	show_state.get_node("value").text = state.name


func _process(delta: float) -> void:
	show_fps.get_node("value").text = str(Engine.get_frames_per_second())
