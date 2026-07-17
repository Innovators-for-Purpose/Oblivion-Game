#extends CanvasLayer
#
#signal on_transition_finished
#
#
#onready var color_rect = $ColorRect
#onready var animation_player = $AnimationPlayer
#
#func _ready():
#	color_rect.visible = false
#	animation_player.animation_finished.connect(_on_animation_finished)
#
##func _on_animation_finished(anim_name):
##	if anim_name == "fade to black":
##		on_transition_finished.emit()
##		animation_player.play("fade back to white")
##	elif anim_name == "fade back to white":
##		color_rect.visible = false
##
#func transition():
#	color_rect.visible = true # Fixed the typo here
#	animation_player.play("fade to black")
#
#
#func _on_AnimationPlayer_animation_finished(anim_name):
#	if anim_name == "fade to black":
#		on_transition_finished.emit()
#		animation_player.play("fade back to white")
#	elif anim_name == "fade back to white":
#		color_rect.visible = false
extends CanvasLayer
onready var AnimationPlayer = $AnimationPlayer

func change_scene(target: String) -> void:
	$AnimationPlayer.play('fade back to white')
	yield($AnimationPlayer,'fade to black')
	get_tree().change_scene("res://scenes/levels/(Finished)AssemblyPlantsave.tscn")
	$AnimationPlayer.play_backwards('fade back to white')

#extends CanvasLayer
#
#onready var anim_player = $AnimationPlayer
#
#func change_scene(target_path: String) -> void:
#	# 1. Fade to black
#	anim_player.play("fade to b")
#	yield(anim_player, "fade back to white")
#
#	# 2. Change the scene safely
#	var error = get_tree().change_scene(target_path)
#	if error != OK:
#		push_error("Failed to load scene: " + target_path)
#
#	# 3. Fade back to transparent
#	anim_player.play_backwards("fade")


