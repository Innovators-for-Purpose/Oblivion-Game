extends Area2D


onready var anim = $Sprite


func _on_Switch_body_entered(body):
	if (body.name == "AlexStates"):
		anim.play("default")


func _on_Switch_body_exited(body):
	if (body.name == "AlexStates"):
		anim.frame = 0


