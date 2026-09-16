extends Area2D

onready var switch__sfx = $"../switch sfx"

onready var anim2 = $AnimatedSprite


func _on_Switch2_body_entered(body):
	if (body.name == "AlexStates"):
		anim2.play("default")
		$CollisionShape2D.disabled = !$CollisionShape2D.disabled
#		switch__sfx.play()
#	else:
#		switch__sfx.stop()




func _on_Switch2_body_exited(body):
	if (body.name == "AlexStates"):
		anim2.frame = 0


func _on_AnimatedSprite_animation_finished():
	$CollisionShape2D.disabled = $CollisionShape2D.disabled
