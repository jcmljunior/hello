extends Control

@export var back_scene : PackedScene

func _on_button_pressed() -> void:
	if not back_scene or not back_scene.can_instantiate():
		print_debug("Oppss, ocorreu um erro ao alterar a cena.")
		return
		
	get_tree().change_scene_to_packed(back_scene)
