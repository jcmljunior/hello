extends CoreButton

func _on_pressed() -> void:
	print_debug("Fechando...")
	get_tree().quit()
