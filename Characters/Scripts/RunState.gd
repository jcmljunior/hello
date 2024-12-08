class_name RunState extends CharacterState

@export var move_speed := 100.0
@export var friction := .25

var input_direction: float

func _enter_state() -> void:
	super._enter_state()

func _process(_delta: float) -> void:
	_character_apply_gravity_handler()
	_character_flipped_sprite_handler()
	_character_flipped_collision_handler()
	input_direction = Input.get_axis("move_left", "move_right")

func _physics_process(_delta: float) -> void:
	player.velocity.x = lerp(player.velocity.x, input_direction * move_speed, friction)
	player.move_and_slide()

func _character_flipped_sprite_handler() -> void:
	var sprite: Sprite2D = player.get_node_or_null("Sprite2D")
	
	if not sprite:
		return
		
	sprite.set_flip_h(input_direction < 0)

func _character_flipped_collision_handler() -> void:
	var collision : CollisionPolygon2D = owner.get_node_or_null("CollisionPolygon2D")
	
	if not collision:
		return
		
	if input_direction < 0:
		collision.set_scale(Vector2(-1, 1))
		
	if input_direction > 0:
		collision.set_scale(Vector2(1, 1))
