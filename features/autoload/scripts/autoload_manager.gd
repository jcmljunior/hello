extends Node

signal on_score_changed

@onready var score := 0 : set=set_score, get=get_score

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
