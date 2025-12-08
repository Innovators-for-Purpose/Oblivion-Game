extends GridContainer

signal items_changed(indexes)
signal selected_changed()


var inventory = preload("res://inven/Inventory.tres")
onready var slot1 = $InventorySlotDisplay
onready var slot2 = $InventorySlotDisplay2
onready var slot3 = $InventorySlotDisplay3
onready var slot4 = $InventorySlotDisplay4
onready var slot5 = $InventorySlotDisplay5
onready var slot6 = $InventorySlotDisplay6
onready var slot7 = $InventorySlotDisplay7
onready var slot8 = $InventorySlotDisplay8
onready var slot9 = $InventorySlotDisplay9
var selected = 0
var prev_item
var items

func _ready():
	items = read_from_JSON("res://json/itemdata.json")
	for key in items.keys():
		items[key]["key"] = key
		inventory.connect("items_changed", self, "_on_items_changed")
	update_inventory_display()
	pass

func read_from_JSON(path):
	var file = File.new() # <--- In Godot 4, replace 'File' with 'Fileaccess
	if file.file_exists(path): #--------------------------
		file.open(path, File.READ) #______________________ Delete in Godot 4
		var data = parse_json(file.get_as_text()) #-------
		file.close() #                                   | Indent back
		return data #_____________________________________
	else: # Delete
		printerr("Invalid path given") # Delete


func get_item_by_key(key):
	if items and items.has(key):
		return items[key].duplicate(true)
	pass	 
func update_inventory_display():
	for item_index in inventory.items.size():
		update_inventory_slot_display(item_index)
	pass

func update_inventory_slot_display(item_index):
	var inventorySlotDisplay = get_child(item_index)
	var item = inventory.items[item_index]
	inventorySlotDisplay.display_item(item)
	pass
		
func _on_items_changed(indexes):
	for item_index in indexes:
		update_inventory_slot_display(item_index)
		pass

func _physics_process(delta):
	if Input.is_action_just_pressed("slot2"):
		Global.get_item_by_key("magnet")
		load("res://scripts/item_scripts/magnet.gd")
		pass	
		
func change_item(index, item: Dictionary, parent: Node):
	# Get the key to compare against currently equipped
	var item_key = item.get("key", "")


	# Unequip if this item is already equipped
	if (selected == index 
	and is_instance_valid(prev_item) and 
	prev_item and prev_item.name == item_key):

		prev_item.queue_free()
		prev_item = null
		return

	# if this is a heal, then it will not show on player and remove item in iv
	if item_key == "heal":
		var itemsprite = Sprite.new()
		var script = load("res://scripts/item_scripts/" + item.script)
		itemsprite.set_script(script)
		add_child(itemsprite)
		itemsprite.queue_free()
		return

	if item_key == "magnet":
		var itemsprite = Sprite.new()
		var area2d = load("res://scripts/item_scripts/magnet.gd").instance()
#		area2d.set_script(script)
		itemsprite.name = item_key
		itemsprite.add_child(area2d)
		parent.add_child(itemsprite)
		prev_item = itemsprite
		return

	
	if item.empty() or not item.has("icon"):
		return

	
	var texture = load("res://textures/" + item.icon)
	if not texture:
		printerr("Texture not found for item icon:", item.icon)
		return

	# Remove previously equipped item
	if is_instance_valid(prev_item):
		if prev_item:
			prev_item.queue_free()


	
	var itemsprite = Sprite.new()
	var script = load("res://scripts/item_scripts/" + item.script)
	itemsprite.name = item_key  
	itemsprite.texture = texture
	itemsprite.set_script(script)
	itemsprite.position = Vector2(90, 0)  

	parent.add_child(itemsprite)
	prev_item = itemsprite		
