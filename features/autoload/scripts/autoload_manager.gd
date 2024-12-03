extends Node

signal on_score_changed
signal on_current_selected_changed

@onready var score := 0 : set=set_score, get=get_score
@onready var current_selected := 0 : set=set_current_selected, get=get_current_selected

func set_score(new_score: int) -> void:
	if new_score == score:
		return
	
	score = new_score
	emit_signal("on_score_changed")

func get_score() -> int:
	return score

# Adiciona pontuação de 0 a 3
func add_score() -> void:
	set_score(clamp(score +1, 0, 3))
	
func remove_score() -> void:
	set_score(clamp(score -1, 0, 3))

func set_current_selected(new_current_selected: int) -> void:
	if current_selected == new_current_selected:
		return
		
	current_selected = new_current_selected
	emit_signal("on_current_selected_changed")


func get_current_selected() -> int:
	return current_selected
