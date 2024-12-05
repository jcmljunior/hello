class_name CharacterState extends State

@onready var sprite: AnimatedSprite2D = owner.get_node("sprite")

func enter_state() -> void:
	super.enter_state()
	_player_animation_handler()
	_player_sprite_direction_handler()


func _player_animation_handler() -> void:
	sprite.play(state_machine.get_current_state().name)


func _player_sprite_direction_handler() -> void:
	if state_machine.get_current_state().name == "idle":
		return
	
	sprite.flip_h = player.direction < 0
