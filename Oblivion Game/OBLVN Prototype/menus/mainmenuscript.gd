extends Node2D


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/levels/(Finished)AssemblyPlantsave.tscn")
	
func _on_Button2_pressed ():
	get_tree().change_scene("res://scenes/levels/(Finished) level0_house.tscn")
	
func _on_Button3_pressed ():
	get_tree().change_scene("res://Facility.tscn")


func _on_Button4_pressed():
	get_tree().change_scene("res://scenes/levels/Outer City.tscn")


func _on_Button5_pressed():
	get_tree().change_scene("res://scenes/levels/Sewers.tscn")


func _on_Button6_pressed():
	get_tree().change_scene("res://Level 7.tscn")
