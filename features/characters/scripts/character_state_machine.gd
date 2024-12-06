extends StateMachine

@onready var player := owner as CharacterBody2D

func _process(delta: float) -> void:
	if not get_auto_start():
		
		if not player.can_moviment and player.is_on_floor():
			player._change_state_handler("spawn")
			set_auto_start(true)
		
		return
	
	if not player.can_moviment and player.velocity.y == 0:
		player._change_state_handler("spawn")
	
	elif Input.is_action_just_pressed("ui_accept") and player.velocity.y <= 0 and player.can_moviment:
		player._change_state_handler("jump")
		
	elif player.direction and player.is_on_floor() and player.can_moviment:
		player._change_state_handler("run")
	
	elif not player.direction and player.is_on_floor() and player.can_moviment:
		player._change_state_handler("idle")
	
	elif player.velocity.y >= 0 :
		player._change_state_handler("land")
