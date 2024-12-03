extends CoreButton

# A Godot aparentemente não permite criar componentes de componentes referênciando cenas.
# Solução alternativa temporaria.
@export_file("*.tscn") var target_scene: String

func _ready() -> void:
		var current_selected := AutoloadManager.get_current_selected()
		if current_selected == get_parent().get_children().find(self):
			grab_focus()

func _on_pressed() -> void:
	if not target_scene:
		return
	
	update_current_selected()
	get_tree().change_scene_to_file(target_scene)

func update_current_selected() -> void:
	AutoloadManager.set_current_selected(get_parent().get_children().find(self))
