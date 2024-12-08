class_name State extends Node

@export var _one_shot := false

func _ready() -> void:
	_exit_state()

func _enter_state() -> void:
	set_process(true)
	set_physics_process(true)
	set_process_unhandled_input(true)

func _exit_state() -> void:
	set_process(false)
	set_physics_process(false)
	set_process_unhandled_input(false)
