extends Button

@export var focus := false

func _ready() -> void:
	if focus : grab_focus()
