extends CharacterBody2D

# Versão 2
@onready var detection_area: Area2D = get_node_or_null("Area2D")
var player: CharacterBody2D

func _ready() -> void:
	if not get_node_or_null("StateMachine/Patrol").get("patrol_points").size():
		return
		
	detection_area.body_entered.connect(_on_area_2d_body_entered)
	detection_area.body_exited.connect(_on_area_2d_body_exited)


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if not body:
		return
	
	if not body.is_in_group("player"):
		return
	
	player = body


func _on_area_2d_body_exited(body: CharacterBody2D) -> void:
	if not body:
		return
	
	if not body.is_in_group("player"):
		return
	
	player = null
