extends Area2D

onready var anim = $Sprite
onready var sfx = $AudioStreamPlayer2D

func _on_Spring_body_entered(body):
	if (body.name == "AlexStates"):
		body.velocity.y = -2100 
		anim.play("default")
		sfx.play()


		


func _on_Spring_body_exited(body):
	if (body.name == "AlexStates"):
		anim.frame = 0
