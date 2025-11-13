extends ColorRect

onready var player = get_node("../../AlexStates")

# var a = 2
# var b = "text"
func _input(event):
	
	if event.is_action_pressed("toggle_inv"):
#		print("I should open inven")
		$InventoryContainer.visible = true
#	if Input.is_action_pressed("ui_inv"):
#		not visible = visible 
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
