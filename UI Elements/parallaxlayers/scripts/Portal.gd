extends Node2D

export(String, FILE, "*.tscn") var destination
var green = false


func _process(delta):
	if green:
		$Sprite.modulate = Color.green
		if Input.is_action_just_pressed("ui_select"):
# warning-ignore:return_value_discarded
			get_tree().change_scene(destination)
	else:
		$Sprite.modulate = Color.white

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		green = true
 
func _on_Area2D_body_exited(body):
	green = false
