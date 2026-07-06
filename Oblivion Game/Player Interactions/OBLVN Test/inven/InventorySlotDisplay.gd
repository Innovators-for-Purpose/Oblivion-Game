extends CenterContainer

var inventorynew = preload("res://inven/Inventory.tres")

onready var itemTextureRect = $ItemTextureRect 
#onready var itemAmountLabel = $ItemTextureRect/ItemAmountLabel


func display_item(item):
	if item is Item:
		itemTextureRect.texture = item.texture
	else:
		itemTextureRect.texture = load("res://Items/whitedot.png")
	
func get_drag_data(_position):
	var item_index = get_index()
	var item = inventorynew.remove_item(item_index)
	if item is Item:
		var data = {}
		data.item = item
		data.item_index = item_index
		var dragPreview = TextureRect.new()
		dragPreview.texture = item.texture
		set_drag_preview(dragPreview)
		inventorynew.drag_data = data
		return data

func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")

func drop_data(_position, data):
	var my_item_index = get_index()
	var my_item = inventorynew.items[my_item_index]
	if my_item is Item and my_item.name == data.item.name:
		my_item.amount += data.item.amount
		inventorynew.emit_signal("items_changed", [my_item_index])
	else:
		inventorynew.swap_items(my_item_index, data.item_index)
		inventorynew.set_item(my_item_index, data.item)
	inventorynew.drag_data = null
