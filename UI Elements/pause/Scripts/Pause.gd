extends CanvasLayer


func _ready():
	set_visible(false)


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Audiocontroller.muffle_audio(!get_tree().paused)
		set_visible(!get_tree().paused)
		get_tree().paused = !get_tree().paused


func _on_Button_pressed():
	Audiocontroller.muffle_audio(false)
	get_tree().paused = false
	set_visible(false)

func set_visible(set_visible):
	for node in get_children():
		node.visible = set_visible
