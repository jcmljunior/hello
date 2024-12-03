extends CoreButton

# A Godot aparentemente não permite criar componentes de componentes referênciando cenas.
# Solução alternativa temporaria.
@export_file("*.tscn") var target_scene: String

func _on_pressed() -> void:
	if not target_scene:
		return
	
	print_debug("Configurando...")
	get_tree().change_scene_to_file(target_scene)
