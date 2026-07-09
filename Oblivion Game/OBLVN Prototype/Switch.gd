extends Area2D

onready var anim = $AnimatedSprite
onready var sfx = $"../SwitchSFX"


func _on_Switch_body_entered(body):
	if (body.name == "AlexStates"):
		anim.play("default")
		sfx.play()


