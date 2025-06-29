extends Node2D

func _ready() -> void:
	Globals.init_new_game()

func _process(delta: float) -> void:
	if Globals.hit_pipe:
		if Globals.pipe_speed > 0.1:
			Globals.pipe_speed = lerp(Globals.pipe_speed, 0, 0.1)
		else:
			Globals.pipe_speed = 0
		Globals.spawn_delay = 9999999
