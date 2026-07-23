#extends Control
#func _ready():
#	hide()
#func resume():
#	get_tree().paused = false
#
#func paused():
#	get_tree().pause = true 
#
#func testescape():
#	if Input.is_action_just_pressed("escape") and get_tree().paused == false:
#		paused()
#	elif Input.is_action_just_pressed("escape") and get_tree().paused == true:
#		resume()
#
#
#
#
#func _on_restart_pressed():
#	get_tree().reload_current_scene()
#
#func _on_resume_pressed():
#	get_tree().paused = false
#	hide()
#
#
#
#
#func _on_quit_pressed():
#	get_tree().change_scene ("res://Node2D.tscn")
#
#func _input (delta):
#	testescape()
extends Control

func _ready():
	hide()
	pause_mode = Node.PAUSE_MODE_PROCESS

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			resume()
		else:
			pause()

func pause():
	get_tree().paused = true
	show() 
func _on_resume_pressed():
	get_tree().paused = false
	hide()
func resume():
	get_tree().paused = false
	hide()
func _on_restart_pressed():
	get_tree().paused = false
#	Global.reset_checkpoint()
	get_tree().reload_current_scene()
func _on_quit_pressed():
	get_tree().change_scene ("res://menus/LevelSelect.tscn")
	get_tree().paused = false
