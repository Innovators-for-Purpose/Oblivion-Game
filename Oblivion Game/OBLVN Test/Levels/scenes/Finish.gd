extends Area2D

func _on_body_enetered(body):
	if (body.name == "KinematicBody2D"):
		get_tree().change_scene_to_file("res://Levels/scenes/level0_house.tscn")
