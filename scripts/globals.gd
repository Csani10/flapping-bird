extends Node

# Session data
var pipe_speed: int = 400
var spawn_delay = 4.0
var score = 0
var hit_pipe = false
var started = false
var new_high_score = false

# Game data
var money: int = 0
var owned_birds = ["Bird-Default"]
var owned_hats = []
var high_score: int = 0
var equipped_bird = "Bird-Default"
var equipped_hat = ""

# Constants
const PIPE = preload("res://scenes/pipe.tscn")

const BIRDS = {
	"Bird-Default": preload("res://assets/birds/Bird-Default.png"),
	"Bird-Blue": preload("res://assets/birds/Bird-Blue.png"),
	"Bird-LightBlue": preload("res://assets/birds/Bird-LightBlue.png"),
	"Bird-Green": preload("res://assets/birds/Bird-Green.png"),
	"Bird-Pink": preload("res://assets/birds/Bird-Pink.png"),
	"Bird-Purple": preload("res://assets/birds/Bird-Purple.png"),
	"Bird-Red": preload("res://assets/birds/Bird-Red.png"),
	"Bird-BlueCheckered": preload("res://assets/birds/Bird-BlueCheckered.png"),
	"Bird-RedCheckered": preload("res://assets/birds/Bird-RedCheckered.png"),
}

const BIRDS_PRICES = {
	"Bird-Default": 0,
	"Bird-Blue": 50,
	"Bird-LightBlue": 50,
	"Bird-Green": 50,
	"Bird-Pink": 50,
	"Bird-Purple": 50,
	"Bird-Red": 50,
	"Bird-BlueCheckered": 100,
	"Bird-RedCheckered": 100,
}

const HATS = {
	"BirthDay-Hat": preload("res://assets/hats/BirthDay-Hat.png"),
	"Top-Hat": preload("res://assets/hats/Top-Hat.png"),
	"Baseball-Hat": preload("res://assets/hats/Baseball-Hat.png"),
	"Beanie-Hat": preload("res://assets/hats/Beanie-Hat.png"),
	"Fedora-Hat": preload("res://assets/hats/Fedora-Hat.png"),
}

const HATS_PRICES = {
	"BirthDay-Hat": 20,
	"Top-Hat": 25,
	"Baseball-Hat": 30,
	"Beanie-Hat": 40,
	"Fedora-Hat": 50,
}

const MEDALS = {
	"Bronze": preload("res://assets/medals/Bronze.png"),
	"Silver": preload("res://assets/medals/Silver.png"),
	"Gold": preload("res://assets/medals/Gold.png"),
	"Platinum": preload("res://assets/medals/Platinum.png"),
}

func _ready() -> void:
	Globals.init_new_game()
	if !Globals.load_save():
		Globals.save_game()

func init_new_game():
	print("Initializing new game...")
	Globals.pipe_speed = 300
	Globals.score = 0
	Globals.spawn_delay = 3.0
	Globals.hit_pipe = false
	Globals.started = false
	Globals.new_high_score = false

func save_game():
	print("Saving game data...")
	var save_data = {
		"money": Globals.money,
		"owned_birds": Globals.owned_birds,
		"owned_hats": Globals.owned_hats,
		"high_score": Globals.high_score,
		"equipped_bird": Globals.equipped_bird,
		"equipped_hat": Globals.equipped_hat
	}
	
	if !FileAccess.file_exists("user://flapbird.json"):
		print("Save file doesn't exist! Creating one...")
		FileAccess.open("user://flapbird.json", FileAccess.WRITE).close()
	
	var save_file = FileAccess.open("user://flapbird.json", FileAccess.WRITE)
	save_file.store_string(JSON.stringify(save_data))
	save_file.close()
	print("Successfully saved game data!")

func load_save():
	print("Loading Save...")
	if !FileAccess.file_exists("user://flapbird.json"):
		print("Failed to load Save! Save file doesn't exist!")
		return false
	
	var save_file = FileAccess.open("user://flapbird.json", FileAccess.READ_WRITE)
	var save_text = save_file.get_as_text()
	print(save_text)
	var save_data = JSON.parse_string(save_text)
	save_file.close()
	if !save_data:
		return false
	Globals.money = save_data["money"]
	Globals.owned_birds = save_data["owned_birds"]
	Globals.owned_hats = save_data["owned_hats"]
	Globals.high_score = save_data["high_score"]
	Globals.equipped_bird = save_data["equipped_bird"]
	Globals.equipped_hat = save_data["equipped_hat"]
	print("Successfully loaded Save!")
	return true
