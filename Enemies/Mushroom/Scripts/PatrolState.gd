extends MushroomState

@export var patrol_points: Array[Marker2D] = []
var move_speed := 30.0
var index := 0
var is_waiting := false

func _enter_state() -> void:
	super._enter_state()
	_animation_handler("Run")

func _process(_delta: float) -> void:
	_flipped_sprite_handler()
	_flipped_collision_handler()
	_flipped_detection_area_handler()

func _physics_process(_delta: float) -> void:
	_apply_gravity_handler()
	
	var target := patrol_points[index].position
	
	if is_waiting:
		mushroom.velocity = lerp(mushroom.velocity, Vector2.ZERO, .3)
	else:
		mushroom.velocity = (target - mushroom.position).normalized() * move_speed
	
	if mushroom.position.distance_to(target) < 10.0:
		index += 1
		is_waiting = [true, false, false].pick_random()
		
		if index >= patrol_points.size():
			index = 0
	
	mushroom.move_and_slide()
