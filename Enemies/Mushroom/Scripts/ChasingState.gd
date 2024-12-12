extends MushroomState

var move_speed := 30.0

func _enter_state() -> void:
	super._enter_state()
	_animation_handler("Run")

func _process(_delta: float) -> void:
	_apply_gravity_handler()
	_flipped_sprite_handler()
	_flipped_collision_handler()
	_flipped_detection_area_handler()

func _physics_process(_delta: float) -> void:
	mushroom.velocity = (owner.get("player").global_position - mushroom.global_position).normalized() * move_speed
	mushroom.move_and_slide()
