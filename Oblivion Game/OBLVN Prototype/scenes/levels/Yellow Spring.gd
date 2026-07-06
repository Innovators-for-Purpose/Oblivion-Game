extends Area2D

onready var anim = $AnimatedSprite

func _on_Yellow_Spring_body_entered(body):
	if (body.name == "AlexStates"):
		body.velocity.y = (-1300 + 100) # Launch upward
		anim.play("default")



func _on_Yellow_Spring_body_exited(body):
	if (body.name == "AlexStates"):
		anim.frame = 0

