extends CanvasLayer

func _unhandled_input(event: InputEvent) -> void:
	if Globals.hit_pipe or Globals.started:
		return
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			Globals.started = true
	elif event is InputEventScreenTouch:
		if event.pressed:
			Globals.started = true

func set_medal():
	if Globals.score >= 40:
		$EndPanel/Medal.texture = Globals.MEDALS["Platinum"]
	elif Globals.score >= 30:
		$EndPanel/Medal.texture = Globals.MEDALS["Gold"]
	elif Globals.score >= 20:
		$EndPanel/Medal.texture = Globals.MEDALS["Silver"]
	elif Globals.score >= 10:
		$EndPanel/Medal.texture = Globals.MEDALS["Bronze"]
	else:
		$EndPanel/Medal.texture = null

func _process(delta: float) -> void:
	$ScoreLabel.text = str(Globals.score)
	set_medal()
	
	$EndPanel/ScoreLabel.text = "Score:\n" + str(Globals.score)
	$EndPanel/HighScoreLabel.text = "High Score:\n" + str(Globals.high_score)
	if Globals.new_high_score:
		$EndPanel/HighScoreLabel.text = "New " + $EndPanel/HighScoreLabel.text
	
	if Globals.started and !Globals.hit_pipe:
		$ScoreLabel.show()
		$PressToStart.hide()
	elif Globals.started and Globals.hit_pipe:
		$PressToStart.hide()
		$ScoreLabel.hide()
		$EndPanel.show()

func apply_money():
	Globals.money += Globals.score + (20 if Globals.new_high_score else 0)
	if Globals.score >= 40:
		Globals.money += 250
	elif Globals.score >= 30:
		Globals.money += 200
	elif Globals.score >= 20:
		Globals.money += 150
	elif Globals.score >= 10:
		Globals.money += 100
	Globals.money = int(Globals.money)

func _on_restart_pressed() -> void:
	apply_money()
	Globals.save_game()
	get_tree().reload_current_scene()


func _on_menu_pressed() -> void:
	apply_money()
	Globals.save_game()
	get_tree().change_scene_to_file("res://menu.tscn")
