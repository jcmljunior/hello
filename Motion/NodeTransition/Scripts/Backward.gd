extends State

@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _process(_delta: float) -> void:
	animation_player.play("backward")
	await animation_player.animation_finished
	
	# Não irá funcionar a transição entre estado se o modo de execução única estiver ativo.
	#get_parent()._change_state_handler(get_node_or_null("Forward"))
