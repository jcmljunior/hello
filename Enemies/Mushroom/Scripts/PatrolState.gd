extends MushroomState

@export var patrol_points: Array[Marker2D] = []
@export var move_speed := 30.0
@export var index := 0

func _enter_state() -> void:
	super._enter_state()
	_animation_handler("Run")

func _process(_delta: float) -> void:
	_flipped_sprite_handler()
	_flipped_collision_handler()

func _physics_process(delta: float) -> void:
	_apply_gravity_handler()
	
	var target := patrol_points[index].position
		
	if not get_parent().is_waiting:
		mushroom.velocity = (target - mushroom.position).normalized() * move_speed
	
	if mushroom.position.distance_to(target) < 10.0:
		index += 1
		get_parent().is_waiting = true
		#get_parent().is_waiting = [true, false, false].pick_random()
		
		if index >= patrol_points.size():
			index = 0
	
	mushroom.move_and_slide()
