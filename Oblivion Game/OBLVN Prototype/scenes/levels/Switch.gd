extends Area2D


onready var anim = $Sprite
onready var switch__sfx = $"../Switch Sfx"


func _on_Switch_body_entered(body):
	if (body.name == "AlexStates"):
		anim.play("default")
		switch__sfx.play()


func _on_Switch_body_exited(body):
	if (body.name == "AlexStates"):
		anim.frame = 0


