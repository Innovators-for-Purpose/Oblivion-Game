extends Area2D



#onready var switch__sfx = $"../Switch Sfx"
onready var anim = $AnimatedSprite





func _on_SwitchSewerBase_body_entered(body):
	if (body.name == "AlexStates"):
		anim.play("default")
#		switch__sfx.play()


func _on_SwitchSewerBase_body_exited(body):
	if (body.name == "AlexStates"):
		anim.frame = 0

