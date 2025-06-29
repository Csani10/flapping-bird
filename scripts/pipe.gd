extends StaticBody2D

func _process(delta: float) -> void:
	if Globals.hit_pipe:
		$Top3.disabled = true
		$Top2.disabled = true
		$Bottom2.disabled = true
		$Bottom3.disabled = true
	
	if !Globals.started:
		return
	
	position.x -= Globals.pipe_speed * delta
	
	if global_position.x <= -560:
		print("Removing: ", name)
		queue_free()
