extends TextureButton

onready var glow = $Glow

func _ready():
	glow.hide()
# warning-ignore:return_value_discarded
	connect("mouse_entered",self,"_on_mouse_entered")
# warning-ignore:return_value_discarded
	connect("mouse_exited",self,"_on_mouse_exited")

func display_item(item):
	if item:
		texture_normal = load("res://inventory/textures/%s" % item.icon)
	else:
		texture_normal = null

	if get_index() == Inventory.selected:
		glow.show()
	elif !item:
		glow.hide()
	else:
		glow.hide()
	

func _on_mouse_entered():
	rect_scale = rect_scale * 1.5

func _on_mouse_exited():
	rect_scale = Vector2(1,1)

