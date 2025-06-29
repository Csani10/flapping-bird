extends Node2D

var pipe_spawn_timer = Timer.new()
var pipe_index = 0
var started_timer = false

func _ready() -> void:
	pipe_spawn_timer.wait_time = Globals.spawn_delay
	pipe_spawn_timer.one_shot = false
	pipe_spawn_timer.connect("timeout", spawn_pipe)
	add_child(pipe_spawn_timer)
	spawn_pipe()

func _process(delta: float) -> void:
	if Globals.started and !started_timer:
		pipe_spawn_timer.start()
		started_timer = true
	pipe_spawn_timer.wait_time = Globals.spawn_delay

func spawn_pipe():
	print("New pipe!")
	var pipe = Globals.PIPE.instantiate()
	pipe.name = "Pipe" + str(pipe_index)
	add_child(pipe)
	pipe.global_position = global_position
	pipe.global_position.y = randi_range(-500, 340)
	pipe_spawn_timer.wait_time = Globals.spawn_delay
	
	pipe_index += 1
