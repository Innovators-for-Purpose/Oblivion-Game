extends GridContainer

var inventory = preload("res://inven/Inventory.tres")

func _ready():
	inventory.connect("items_changed", self, "_on_items_changed")
#	update_inventory_display()
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
