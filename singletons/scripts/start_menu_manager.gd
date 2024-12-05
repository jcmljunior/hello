extends Node

signal on_current_selected_changed

var current_selected := 0 : set=set_current_selected, get=get_current_selected

func set_current_selected(new_current_selected: int) -> void:
	if current_selected == new_current_selected:
		return
		
	current_selected = new_current_selected
	emit_signal("on_current_selected_changed")


func get_current_selected() -> int:
	return current_selected
