extends Area2D

onready var anim = $AnimatedSprite
onready var sfx = $AudioStreamPlayer2D



func _on_Short_Yellow_Spring_body_entered(body):
	if (body.name == "AlexStates"):
		body.velocity.y = (-1300 + 100) 
		anim.play("default")
		sfx.play()




func _on_Short_Yellow_Spring_body_exited(body):
	if (body.name == "AlexStates"):
		anim.frame = 0

