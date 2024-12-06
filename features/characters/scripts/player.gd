extends CharacterBody2D

@export_group("State")
@export_subgroup("Idle")
@export_range(0, 1, .05) var friction := 0.25
@export_subgroup("Run")
@export var move_speed := 300.0
@export_subgroup("Jump")
@export var jump_speed := -400.0


@onready var state_machine: StateMachine = $state_machine

var direction: int

var can_moviment := false

func _change_state_handler(state: String) -> void:
	state_machine._change_state_handler(state_machine.get_node(state))

func _process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	
	#print()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()


func _on_timer_spawn_timeout() -> void:
	can_moviment = true
