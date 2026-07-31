extends Node2D


func _on_Button_pressed():
	get_tree().change_scene ("res://menus/LevelSelect.tscn")


func _on_Button2_pressed():
	get_tree().quit()
