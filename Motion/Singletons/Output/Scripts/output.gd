extends CanvasLayer

@onready var scroll_container: ScrollContainer = %ScrollContainer
@onready var hint: RichTextLabel = %RichTextLabel

func print(value) -> void:
	hint.text += "[%s] %s\n" % [Time.get_time_string_from_system(), str(value)]
	scroll_to_bottom()

func scroll_to_bottom() -> void:
	await get_tree().process_frame
	scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().max_value
