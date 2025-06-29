extends Node2D


func _process(delta: float) -> void:
	#if !Globals.started:
	#	return
	if Globals.pipe_speed - 180 > 0:
		global_position.x -= (Globals.pipe_speed - 180) * delta
	
	if global_position.x <= -990:
		global_position.x = 930
