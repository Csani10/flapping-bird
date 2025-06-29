extends Node2D

@onready var item_list_bird: ItemList = $CanvasLayer/ShopPanel/VBoxContainer/ItemListBird
@onready var item_list_hat: ItemList = $CanvasLayer/ShopPanel/VBoxContainer/ItemListHat
@onready var equip_button: Button = $CanvasLayer/ShopPanel/VBoxContainer/HBoxContainer/EquipButton
@onready var buy_button: Button = $CanvasLayer/ShopPanel/VBoxContainer/HBoxContainer/BuyButton
@onready var money_label: Label = $CanvasLayer/ShopPanel/MoneyLabel

func _ready() -> void:
	Globals.init_new_game()
	init_shop_list_bird()
	init_shop_list_hat()

func init_shop_list_bird():
	for bird in Globals.BIRDS.keys():
		item_list_bird.add_icon_item(Globals.BIRDS[bird])

func init_shop_list_hat():
	for hat in Globals.HATS.keys():
		item_list_hat.add_icon_item(Globals.HATS[hat])

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")


func _on_tab_bar_tab_changed(tab: int) -> void:
	item_list_hat.deselect_all()
	item_list_bird.deselect_all()
	if tab == 0:
		item_list_bird.show()
		item_list_hat.hide()
	elif tab == 1:
		item_list_bird.hide()
		item_list_hat.show()

func _on_close_button_pressed() -> void:
	$CanvasLayer/ShopPanel.hide()
	$CanvasLayer/MainPanel.show()

func _on_shop_pressed() -> void:
	$CanvasLayer/ShopPanel.show()
	$CanvasLayer/MainPanel.hide()

func _process(delta: float) -> void:
	money_label.text = "Money: " + str(Globals.money)
	
	var tab = $CanvasLayer/ShopPanel/VBoxContainer/TabBar.current_tab
	
	if tab == 0:
		var item = item_list_bird.get_selected_items()
		if item.size() > 0:
			equip_button.disabled = false if Globals.BIRDS.keys()[item[0]] != Globals.equipped_bird and Globals.BIRDS.keys()[item[0]] in Globals.owned_birds else true
			buy_button.disabled = true if Globals.BIRDS.keys()[item[0]] in Globals.owned_birds else false
			buy_button.text = "Buy - " + str(Globals.BIRDS_PRICES[Globals.BIRDS_PRICES.keys()[item[0]]]) + " Money"
		else:
			equip_button.disabled = true
			buy_button.disabled = true
			
	elif tab == 1:
		var item = item_list_hat.get_selected_items()
		if item.size() > 0:
			equip_button.disabled = false if Globals.HATS.keys()[item[0]] != Globals.equipped_hat and Globals.HATS.keys()[item[0]] in Globals.owned_hats else true
			buy_button.disabled = true if Globals.HATS.keys()[item[0]] in Globals.owned_hats else false
			buy_button.text = "Buy - " + str(Globals.HATS_PRICES[Globals.HATS_PRICES.keys()[item[0]]]) + " Money"
		else:
			equip_button.disabled = true
			buy_button.disabled = true


func _on_buy_button_pressed() -> void:
	var tab = $CanvasLayer/ShopPanel/VBoxContainer/TabBar.current_tab
	
	if tab == 0:
		var item = item_list_bird.get_selected_items()
		if item.size() > 0:
			var itm = item[0]
			if Globals.money >= Globals.BIRDS_PRICES[Globals.BIRDS.keys()[itm]]:
				Globals.owned_birds.append(Globals.BIRDS.keys()[itm])
				Globals.money -= Globals.BIRDS_PRICES[Globals.BIRDS.keys()[itm]]
				Globals.save_game()
	
	elif tab == 1:
		var item = item_list_hat.get_selected_items()
		if item.size() > 0:
			var itm = item[0]
			if Globals.money >= Globals.HATS_PRICES[Globals.HATS.keys()[itm]]:
				Globals.owned_hats.append(Globals.HATS.keys()[itm])
				Globals.money -= Globals.HATS_PRICES[Globals.HATS.keys()[itm]]
				Globals.save_game()


func _on_equip_button_pressed() -> void:
	var tab = $CanvasLayer/ShopPanel/VBoxContainer/TabBar.current_tab
	
	if tab == 0:
		var item = item_list_bird.get_selected_items()
		if item.size() > 0:
			var itm = item[0]
			Globals.equipped_bird = Globals.BIRDS.keys()[itm]
			Globals.save_game()
	
	elif tab == 1:
		var item = item_list_hat.get_selected_items()
		if item.size() > 0:
			var itm = item[0]
			Globals.equipped_hat = Globals.HATS.keys()[itm]
			Globals.save_game()

var madeby_hover = false

func _input(event: InputEvent) -> void:
	if madeby_hover:
		if event is InputEventScreenTouch:
			if event.pressed:
				OS.shell_open("https://csani10.itch.io")
		elif event is InputEventMouseButton:
			if event.pressed:
				OS.shell_open("https://csani10.itch.io")

func _on_panel_mouse_entered() -> void:
	madeby_hover = true
	print("enter")

func _on_panel_mouse_exited() -> void:
	madeby_hover = false
	print("exit")
