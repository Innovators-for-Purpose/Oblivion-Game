extends SlotContainer

func _ready():
	display_item_slots(Inventory.cols, 1)

func _input(event):
	if event is InputEventKey:
		if[KEY_1,KEY_2,KEY_3,KEY_4].has(event.scancode) and event.is_pressed():
			Inventory.set_selected(event.scancode - 49)
			
