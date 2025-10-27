extends Node

# Declare member variables here. Examples:
signal items_changed(indexes)
signal selected_changed()



var cols = 4
var rows = 1
var slots = cols * rows
var items = []
var selected = 0
var prev_item

func _ready():
	for _i in range(slots):
		items.append({})
	items[0] = Global.get_item_by_key("heal")
	items[1] = Global.get_item_by_key("stun_gun")
	items[2] = Global.get_item_by_key("magnet")
	items[3] = Global.get_item_by_key("grapple")
	print(items)


func set_item(index, item):
	var previous_item = items[index]
	items[index] = item
	emit_signal("items_changed", [index])
	return previous_item
# warning-ignore:unused_argument


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
		var script = load("res://inventory/scripts/item_scripts/" + item.script)
		itemsprite.set_script(script)
		add_child(itemsprite)
		itemsprite.queue_free()
		return

	if item_key == "magnet":
		var itemsprite = Sprite.new()
		var area2d = preload("res://inventory/scenes/Area2D.tscn").instance()
#		area2d.set_script(script)
		itemsprite.name = item_key
		itemsprite.add_child(area2d)
		parent.add_child(itemsprite)
		prev_item = itemsprite
		return

	
	if item.empty() or not item.has("icon"):
		return

	
	var texture = load("res://inventory/textures/" + item.icon)
	if not texture:
		printerr("Texture not found for item icon:", item.icon)
		return

	# Remove previously equipped item
	if is_instance_valid(prev_item):
		if prev_item:
			prev_item.queue_free()


	
	var itemsprite = Sprite.new()
	var script = load("res://inventory/scripts/item_scripts/" + item.script)
	itemsprite.name = item_key  
	itemsprite.texture = texture
	itemsprite.set_script(script)
	itemsprite.position = Vector2(90, 0)  

	parent.add_child(itemsprite)
	prev_item = itemsprite

func remove_item(index):
	var previous_item = items[index].duplicate()
	items[index].clear()
	emit_signal("items_changed", [index])
	return previous_item

func broadcast_signal(indexes):
	emit_signal("items_changed", indexes)
	for index in indexes:
		if index == selected:
			emit_signal("selected_changed")

func set_selected(new_selected):
	var last_selected = selected
	selected = new_selected
	broadcast_signal([selected, last_selected])
#	print(get_selected())

func get_selected():
	return items[selected]
