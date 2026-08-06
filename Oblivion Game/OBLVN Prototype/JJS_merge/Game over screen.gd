extends Control


func _on_Button_pressed():
	print(Levelmanager.get_current_level())
	get_tree().change_scene (Levelmanager.levels[Levelmanager.current_level_index])


func _on_Button2_pressed():
	get_tree().change_scene ("res://menus/Options menu.tscn")
