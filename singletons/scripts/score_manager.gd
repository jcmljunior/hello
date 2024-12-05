extends Node

signal on_score_changed

var score := 0 : set=set_score, get=get_score

func set_score(new_score: int) -> void:
	if new_score == score:
		return
	
	score = new_score
	on_score_changed.emit()

func get_score() -> int:
	return score
	
func add_score() -> void:
	set_score(clamp(score +1, 0, 3))
	
func remove_score() -> void:
	set_score(clamp(score -1, 0, 3))
