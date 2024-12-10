extends Node

signal on_score_changed(score: int)

var _score := 0

func set_score(score: int) -> void:
	if _score == score:
		return
	
	_score = score
	on_score_changed.emit(score)

func get_score() -> int:
	return _score
