class_name State extends Node

@onready var player: CharacterBody2D = owner
@onready var state_machine: StateMachine = get_parent()

@export_group("Modo de Execução")
@export var one_shot := false


func _ready() -> void:
	if not state_machine:
		return
	
	exit_state()


func enter_state() -> void:
	set_process(true)
	set_physics_process(true)
	set_process_unhandled_input(true)


func exit_state() -> void:
	set_process(false)
	set_physics_process(false)
	set_process_unhandled_input(false)
