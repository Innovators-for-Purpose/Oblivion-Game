extends Area2D

var p_in = false


func _process(_delta):
	if p_in:
		if Input.is_action_just_pressed("ui_select"):
			pass
#			get_tree().change_scene_to()



func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		p_in = true
		body.zoom_amount(1,1)




func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		p_in = false
		body.zoom_amount(0.4,0.4)
