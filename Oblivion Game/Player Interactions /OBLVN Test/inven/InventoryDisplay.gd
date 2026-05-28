extends GridContainer

var inventory = preload("res://inven/Inventory.tres")

func _ready():
	inventory.connect("items_changed", self, "_on_items_changed")
	inventory.make_items_unique()
	print(inventory.items)
	update_inventory_display()

func update_inventory_display():
	for item_index in inventory.items.size():
		update_inventory_slot_display(item_index)

func update_inventory_slot_display(item_index):
	var inventorySlotDisplay = get_child(item_index)
	var item = inventory.items[item_index]
	inventorySlotDisplay.display_item(item)

func _on_items_changed(indexes):
	for item_index in indexes:
		update_inventory_slot_display(item_index)

func _unhandled_input(event):
	if event.is_action_released("ui_left_mouse"):
		if inventory.drag_data is Dictionary:
			inventory.set_item(inventory.drag_data.item_index, inventory.drag_data.item)

#func _physics_process(delta):
#	if Input.is_action_just_pressed("slot2"):
#		Global.get_item_by_key("magnet")
#		load("res://scripts/item_scripts/magnet.gd")
#		pass	
#
#func change_item(index, item: Dictionary, parent: Node):
#	# Get the key to compare against currently equipped
#	var item_key = item.get("key", "")
#
#
#	# Unequip if this item is already equipped
#	if (selected == index 
#	and is_instance_valid(prev_item) and 
#	prev_item and prev_item.name == item_key):
#
#		prev_item.queue_free()
#		prev_item = null
#		return
#
#	# if this is a heal, then it will not show on player and remove item in iv
#	if item_key == "heal":
#		var itemsprite = Sprite.new()
#		var script = load("res://scripts/item_scripts/" + item.script)
#		itemsprite.set_script(script)
#		add_child(itemsprite)
#		itemsprite.queue_free()
#		return
#
#	if item_key == "magnet":
#		var itemsprite = Sprite.new()
#		var area2d = load("res://scripts/item_scripts/magnet.gd").instance()
##		area2d.set_script(script)
#		itemsprite.name = item_key
#		itemsprite.add_child(area2d)
#		parent.add_child(itemsprite)
#		prev_item = itemsprite
#		return
#
#
#	if item.empty() or not item.has("icon"):
#		return
#
#
#	var texture = load("res://textures/" + item.icon)
#	if not texture:
#		printerr("Texture not found for item icon:", item.icon)
#		return
#
#	# Remove previously equipped item
#	if is_instance_valid(prev_item):
#		if prev_item:
#			prev_item.queue_free()
#
#
#
#	var itemsprite = Sprite.new()
#	var script = load("res://scripts/item_scripts/" + item.script)
#	itemsprite.name = item_key  
#	itemsprite.texture = texture
#	itemsprite.set_script(script)
#	itemsprite.position = Vector2(90, 0)  
#
#	parent.add_child(itemsprite)
#	prev_item = itemsprite		
