extends State

@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _process(_delta: float) -> void:
	animation_player.play("forward")
	await animation_player.animation_finished
