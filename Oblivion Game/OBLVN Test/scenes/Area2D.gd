extends Area2D

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene ("res://Node2D.tscn")




func _on_Area2D2_body_entered(body):
		if body.is_in_group("player"):
			get_tree().change_scene ("res://Node2D.tscn")
