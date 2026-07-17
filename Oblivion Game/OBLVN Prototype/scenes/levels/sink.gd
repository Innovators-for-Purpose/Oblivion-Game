extends Area2D
onready var anim = $Sprite

func _on_sink_body_entered(body):
	if (body.name == "AlexStates"):
		anim.play("on")
	else:
		anim.play("off")


func _on_sink_body_exited(body):
	if (body.name == "AlexStates"):
		anim.play("off")
