extends Area2D

onready var glow = $AnimatedSprite



func _on_CameraScan_body_entered(body):
	if (body.name == "AlexStates"):
		glow.play("on")
		queue_free()
