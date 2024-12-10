@tool
extends CanvasLayer

@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _ready() -> void:
	if Engine.is_editor_hint():
		return set_visible(false)
	
	set_visible(true)
