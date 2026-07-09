extends Area2D

onready var anim = $anim
onready var sfx = $sfx


func _on_Area2D_body_entered(body):
	Checkpoint.last_position = global_position
	if (body.name == "AlexStates"):
		anim.play("Activated")
		sfx.play()
	else:
		anim.play("Not Activated")
