class_name PlayerState extends State

var input_vector := Vector2.ZERO : set=set_input_vector, get=get_input_vector
var input_direction := Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") : get=get_gravity

func _process(delta: float) -> void:	
	input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	input_direction = input_vector.normalized()

func set_input_vector(new_input_vector: Vector2) -> void:
	if input_vector == new_input_vector:
		return
	
	input_vector = new_input_vector

func get_input_vector() -> Vector2:
	return input_vector

func set_input_direction(new_input_direction: Vector2) -> void:
	if input_direction == new_input_direction:
		return
	
	input_direction = new_input_direction

func get_input_direction(new_direction: Vector2) -> Vector2:
	return input_direction

func get_input_direction_y() -> int:
	return input_direction.y

func get_input_direction_x() -> int:
	return input_direction.x

func get_player() -> CharacterBody2D:
	return owner

func get_gravity() -> int:
	return gravity


func _gravity_handler(delta: float) -> void:
	get_player().velocity.y += get_gravity() * delta
