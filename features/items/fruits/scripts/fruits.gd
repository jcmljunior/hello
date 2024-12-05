extends Area2D

# Define o efeito visual que o item terá após ser coletado.
@export var _effect : PackedScene

# Define a pontuação que o item oferecera ao jogador.
@export var _score := 1 as int
# Define a probabilidade do jogador receber a pontuação bonus.
@export var _chance := 10 as int
# Define a pontuação bonus.
@export var _bonus_score := 2 as int

# Nó de referência para instancia de efeitos visuais.
@onready var spawn := get_node_or_null("spawn") as Marker2D
@onready var sprite := get_node_or_null("sprite") as Sprite2D
@onready var collision := get_node_or_null("collision") as CollisionPolygon2D
@onready var collectable := get_node_or_null("collectable") as AudioStreamPlayer2D


func _generate_bonus_score(score: int, bonus_score: int, chance: int) -> Array:
	var scores := []
	
	# Define a quantidade de elementos com pontuação bônus.
	var bonus_count := int(100 * chance / 100)
	
	var current_score := ScoreManager.get_score()

	# Adiciona os elementos com pontuação bônus.
	for i in range(bonus_count):
		scores.append(current_score + bonus_score)

	# Completa os elementos faltantes para chegar em 100.
	for i in range(100 - bonus_count):
		scores.append(current_score + score)

	# Embaralha os itens para garantir a aleatoriedade.
	scores.shuffle()

	return scores


func _on_body_entered(_body: CharacterBody2D) -> void:
	var node := _effect.instantiate()
	
	set_monitoring.call_deferred(false)
	sprite.set_visible.call_deferred(false)
	collision.set_disabled.call_deferred(true)
	collectable.play()
	
	# Adiciona a pontuação do jogador considerando um valor bonus por cada item coletado.
	ScoreManager.set_score(_generate_bonus_score(_score, _bonus_score, _chance).pick_random())
	
	# Inicialização do efeito visual.
	spawn.add_child(node)
	
	# Aguarda a animação terminar para continuar.
	# Importante para o processo de finalização do objeto ocorrer na ordem correta.
	await node.get_node("animation").animation_finished
