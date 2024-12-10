@tool
extends CanvasLayer

@onready var animation_player: AnimationPlayer = %AnimationPlayer


func _ready() -> void:
	if Engine.is_editor_hint():
		return set_visible(false)
	
	set_visible(true)
	_animation_backward()
	

func _animation_forward() -> void:
	animation_player.play("forward")
	
func _animation_backward() -> void:
	animation_player.play("backward")
