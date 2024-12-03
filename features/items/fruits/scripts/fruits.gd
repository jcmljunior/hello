extends Area2D

@export var score := 0
@export_file("*.tscn") var fx : String

@onready var sprite: Sprite2D = %sprite
@onready var spawn : Marker2D = %spawn
@onready var animation: AnimationPlayer = %animation
@onready var collision: CollisionPolygon2D = %collision

func _ready() -> void:
	ScoreManager.connect("on_score_changed", _on_score_changed)

func _on_score_changed() -> void:
	print("A pontuação atual do jogador é: ", ScoreManager.get_score())

func _on_body_entered(body: Node2D) -> void:
	if not body is CharacterBody2D:
		return
	
	set_monitoring.call_deferred(false)
	set_monitorable.call_deferred(false)
	sprite.set_visible.call_deferred(false)
	collision.set_disabled.call_deferred(true)
	ScoreManager.add_score()
	
	await _spawn_effect(load(fx))
	
	queue_free()

func _spawn_effect(target: PackedScene) -> void:
	var effect := target.instantiate()
	
	spawn.add_child(effect)
	
	# Aguarda a animação terminar para continuar.
	# Importante para o processo de finalização do objeto ocorrer na ordem correta.
	await effect.find_child("animation").animation_finished
