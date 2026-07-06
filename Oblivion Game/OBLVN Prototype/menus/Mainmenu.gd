extends Sprite
onready var button: Button = $"%Button2"
onready var button_2: Button = $"%Button2"
func _ready() -> void:
	button.grab_focus()
onready var lvl1_locked: ColorRect = $"../lvl1_locked"
onready var lvl2_locked: ColorRect = $"../lvl2_locked"
onready var Lock1: Sprite = $"."
