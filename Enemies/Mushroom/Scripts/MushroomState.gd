class_name MushroomState extends State

@onready var mushroom: CharacterBody2D = owner


func _apply_gravity_handler() -> void:
	if mushroom.is_on_floor():
		return
	
	mushroom.velocity += mushroom.get_gravity() * mushroom.get_process_delta_time()


func _animation_handler(animation_name: String) -> void:
	var animation: AnimationPlayer = mushroom.get_node_or_null("AnimationPlayer")
	
	if not animation:
		return
	
	animation.play(animation_name)

func _flipped_sprite_handler() -> void:
	var sprite: Sprite2D = mushroom.get_node_or_null("Sprite2D")
	
	if not sprite:
		return
		
	sprite.set_flip_h(mushroom.velocity.x > 0)


func _flipped_collision_handler() -> void:
	var collision : CollisionPolygon2D = owner.get_node_or_null("CollisionPolygon2D")
	
	if not collision:
		return
		
	if mushroom.velocity.x < 0:
		collision.set_scale(Vector2(-1, 1))
		
	if mushroom.velocity.x > 0:
		collision.set_scale(Vector2(1, 1))
