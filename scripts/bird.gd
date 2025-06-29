extends CharacterBody2D

const FLAP_VELOCITY = -900.0
const GRAVITY = 3

var start_pos

func _ready() -> void:
	start_pos = global_position
	set_bird_hat()

func set_bird_hat():
	if Globals.equipped_bird in Globals.owned_birds:
		$SpriteMid/BirdSprite.texture = Globals.BIRDS[Globals.equipped_bird]
	else:
		$SpriteMid/BirdSprite.texture = Globals.BIRDS["Bird-Default"]
	
	if Globals.equipped_hat in Globals.owned_hats:
		$SpriteMid/HatSprite.texture = Globals.HATS[Globals.equipped_hat]
	else:
		$SpriteMid/HatSprite.texture = null

func _unhandled_input(event: InputEvent) -> void:
	if Globals.hit_pipe or !Globals.started:
		return
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			velocity.y = FLAP_VELOCITY
	elif event is InputEventScreenTouch:
		if event.pressed:
			velocity.y = FLAP_VELOCITY

func _physics_process(delta: float) -> void:
	set_bird_hat()
	if !Globals.started:
		return
	
	global_position.x = start_pos.x
	
	if not is_on_floor():
		velocity += get_gravity() * delta * GRAVITY
		
	$SpriteMid.rotation = lerp($SpriteMid.rotation, deg_to_rad(velocity.y * 0.05), 0.2)
	$SpriteMid.rotation = clamp($SpriteMid.rotation, deg_to_rad(-40), deg_to_rad(63.5))
	
	move_and_slide()


func _on_area_body_entered(body: Node2D) -> void:
	if body.name.contains("Pipe"):
		Globals.hit_pipe = true
		print("Hit Pipe")
		$Area/Collision.call_deferred("set_disabled", true)
	elif body.name.contains("Floor"):
		Globals.hit_pipe = true
		print("Hit Floor")
		$Area/Collision.call_deferred("set_disabled", true)

func _on_area_area_entered(area: Area2D) -> void:
	if area.name == "PointArea":
		Globals.score += 1
		print("Added 1 score")
		print("New score: ", Globals.score)
		
		if Globals.score > Globals.high_score:
			print("New high score!")
			Globals.high_score = int(Globals.score)
			Globals.new_high_score = true
