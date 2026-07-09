extends Area2D

onready var anim = $AnimatedSprite


func _on_Switch_body_entered(body):
	if (body.name == "AlexStates"):
		anim.play("default")


