extends Area2D




onready var anim = $Sprite
onready var switch__sfx = $"../switch sfx"


func _on_Switch_body_entered(body):
	if (body.name == "AlexStates"):
		anim.play("default")
		switch__sfx.play()
	else:
		switch__sfx.stop()


func _on_Switch_body_exited(body):
	if (body.name == "AlexStates"):
		anim.frame = 0
