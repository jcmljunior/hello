extends CoreButton

@export var target_scene: PackedScene

func _on_pressed() -> void:
	if not target_scene or not target_scene.can_instantiate():
		print_debug("Oppss, ocorreu um erro ao alterar a cena.")
		return
	
	print_debug("Configurando...")
	get_tree().change_scene_to_packed(target_scene)
