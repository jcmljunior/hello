extends MushroomState

var move_speed := 30.0

func _enter_state() -> void:
	super._enter_state()
	_animation_handler("Run")

func _process(_delta: float) -> void:
	_apply_gravity_handler()
	_flipped_sprite_handler()
	_flipped_collision_handler()

func _physics_process(_delta: float) -> void:
	var direction : Vector2 = (mushroom.get("player").global_position - mushroom.global_position).normalized()
	mushroom.velocity = Vector2(direction.x * move_speed, mushroom.velocity.y).normalized() * move_speed
	mushroom.move_and_slide()
