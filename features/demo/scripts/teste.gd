extends Control

@export var back_scene : PackedScene
@onready var label: Label = %Label

func _ready() -> void:
	AutoloadManager.connect("on_score_changed", _on_score_changed)

func _on_button_pressed() -> void:
	if not back_scene or not back_scene.can_instantiate():
		print_debug("Oppss, ocorreu um erro ao alterar a cena.")
		return
		
	get_tree().change_scene_to_packed(back_scene)


func _on_score_button_pressed() -> void:
	AutoloadManager.add_score()

func _on_decrement_button_pressed() -> void:
	AutoloadManager.remove_score()

func _on_score_changed() -> void:
	label.text = str(AutoloadManager.get_score())
