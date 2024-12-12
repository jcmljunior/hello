class_name CharacterState extends State

@onready var player: CharacterBody2D = owner

func _enter_state() -> void:
	super._enter_state()
	_animation_handler()

func _apply_gravity_handler() -> void:
	if player.is_on_floor():
		return
	
	player.velocity += player.get_gravity() * player.get_process_delta_time()

func _animation_handler() -> void:
	var animation: AnimationPlayer = player.get_node_or_null("AnimationPlayer")
	
	if not animation:
		return
	
	animation.play(get_parent().get_current_state().name)
