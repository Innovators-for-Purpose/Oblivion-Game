extends Control
#cred: https://medium.com/@thrivevolt/
#      making-a-grid-inventory-system-with-godot-727efedb71f7#f1d3

onready var clrrect = $ColorRect

export var menu_size = 0.15
export var lerp_speed = 0.2

onready var player = get_node("../../AlexStates")

var _popped_up = false
var up_anchor = Vector2(1-menu_size,1)
var down_anchor = Vector2(1,1+menu_size)
var _target_anchor = down_anchor
var hb_tggle = false

func _ready():
	hide()
	for item_slot in get_tree().get_nodes_in_group("item_slot"):
		var index = item_slot.get_index()
		item_slot.connect("pressed", self, "_on_ItemSlot_gui_input", [index])

func _process(_delta):
	anchor_top = lerp(anchor_top, _target_anchor.x,lerp_speed)
	anchor_bottom = lerp(anchor_bottom, _target_anchor.y,lerp_speed)


func _input(event):
	if event is InputEventKey and event.is_action_pressed("toggle_inv"):
		if hb_tggle:
			show()
			_target_anchor = up_anchor
			hb_tggle = !hb_tggle
		else:
			_target_anchor = down_anchor
			hb_tggle = !hb_tggle
			yield(get_tree().create_timer(0.2),"timeout")
			hide()

func _on_ItemSlot_gui_input(index):
	select_item(index)
	Inventory.change_item(index,Inventory.items[index],player)

func select_item(index):
	Inventory.set_selected(index)
