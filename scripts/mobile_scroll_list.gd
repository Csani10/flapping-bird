extends ItemList

func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		get_v_scroll_bar().value -= event.relative.y
	elif event is InputEventMouseMotion:
		if event.button_mask == 1:
			get_v_scroll_bar().value -= event.relative.y
