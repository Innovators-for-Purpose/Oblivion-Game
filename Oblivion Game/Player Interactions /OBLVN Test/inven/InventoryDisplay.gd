extends GridContainer

signal items_changed(indexes)
signal selected_changed(slot_index)

var inventory = preload("res://inven/Inventory.tres")
var items
var selected = 0

func read_from_JSON(path):
	var file = File.new()
	if file.file_exists(path):
		file.open(path, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		return data
	else:
		printerr("Invalid path given")
		return {}

func _ready():
	items = read_from_JSON("res://json/itemdata.json")

	for key in items.keys():
		items[key]["key"] = key

	inventory.connect("items_changed", self, "_on_items_changed")
	update_inventory_display()

func _input(event):
	for i in range(9):
		if event.is_action_pressed("slot" + str(i+1)):
			emit_signal("selected_changed", i)
			break

func update_inventory_display():
	for i in range(inventory.items.size()):
		update_inventory_slot_display(i)

func update_inventory_slot_display(i):
	var slot = get_child(i)
	var item = inventory.items[i]
	slot.display_item(item)

func _on_items_changed(indexes):
	for i in indexes:
		update_inventory_slot_display(i)
