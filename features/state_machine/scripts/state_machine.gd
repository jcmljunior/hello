class_name StateMachine extends Node

@export var _auto_start := true

var _current_state: Node : set=set_current_state, get=get_current_state
var _previous_state: Node : set=set_previous_state, get=get_previous_state


func _ready() -> void:
	if not get_child_count():
		return
		
	if not get_auto_start():
		return
	
	_change_state_handler(get_children().front())
	

func set_current_state(state: Node) -> void:
	if _current_state == state:
		return
	
	_current_state = state

func get_current_state() -> Node:
	return _current_state


func set_previous_state(state: Node) -> void:
	if _current_state == state:
		return
	
	_current_state = state

func get_previous_state() -> Node:
	return _current_state

func set_auto_start(new_auto_start: bool) -> void:
	if _auto_start == new_auto_start:
		return
	
	_auto_start = new_auto_start

func get_auto_start() -> bool:
	return _auto_start


func _current_state_handler() -> void:
	if not get_current_state():
		return
	
	if not get_current_state().has_method("enter_state"):
		return
	
	get_current_state().enter_state()


func _previous_state_handler() -> void:
	if not get_previous_state():
		return
		
	if not get_previous_state().has_method("exit_state"):
		return
		
	get_previous_state().exit_state()
	_one_shot_handler()


func _one_shot_handler() -> void:
	if not get_previous_state().one_shot:
		return
	
	remove_child(get_previous_state())

func _change_state_handler(state: Node) -> void:
	if get_current_state() == state:
		return
	
	set_current_state(state)
	_previous_state_handler()
	_current_state_handler()
	set_previous_state(state)
