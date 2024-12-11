class_name RunState extends CharacterState

@export var move_speed := 100.0
@export var friction := 1.0

var input_direction: float

func _enter_state() -> void:
	super._enter_state()

func _process(_delta: float) -> void:
	input_direction = Input.get_axis("move_left", "move_right")
	
	_flipped_sprite_handler(player.get_node_or_null("Sprite2D"))
	_flipped_collision_handler(player.get_node_or_null("CollisionPolygon2D"))
	_flipped_collision_handler(player.get_node_or_null("HurtBox/CollisionPolygon2D"))

func _physics_process(delta: float) -> void:
	_apply_gravity_handler()
	player.velocity.x = lerp(player.velocity.x, input_direction * move_speed, friction * delta)
	player.move_and_slide()

func _flipped_sprite_handler(sprite: Sprite2D) -> void:
	if not sprite:
		return
		
	sprite.set_flip_h(input_direction < 0)

func _flipped_collision_handler(collision: CollisionPolygon2D) -> void:
	if not collision:
		return
		
	if input_direction < 0:
		collision.set_scale(Vector2(-1, 1))
		
	if input_direction > 0:
		collision.set_scale(Vector2(1, 1))
