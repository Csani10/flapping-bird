extends StaticBody2D


func _process(delta: float) -> void:
	#if !Globals.started:
	#	return
	
	global_position.x -= (Globals.pipe_speed) * delta
	
	if global_position.x <= -930:
		global_position.x = 930
