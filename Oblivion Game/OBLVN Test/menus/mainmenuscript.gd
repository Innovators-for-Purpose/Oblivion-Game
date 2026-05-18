extends Node2D


func _on_Button_pressed():
	get_tree().change_scene("res://../Levels/scenes/AssemblyPlant.tscn")
func _on_Button2_pressed ():
	get_tree().change_scene("res://..//Levels/scenes/level0_house.tscn")
func _on_Button3_pressed ():
	get_tree().change_scene("res://../Levels/scenes/Main.tscn")
