extends Area2D

onready var anim = $Sprite




func _on_Spring_body_entered(body):
	if (body.name == "AlexStates"):
		body.velocity.y = -2100 # Launch upward
		anim.play("default")


		


func _on_Spring_body_exited(body):
	if (body.name == "AlexStates"):
		anim.frame = 0
