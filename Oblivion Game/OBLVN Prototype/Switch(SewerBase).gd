extends Area2D



#onready var switch__sfx = $"../Switch Sfx"
onready var anim = $AnimatedSprite
onready var collision_shape_2d = $CollisionShape2D





func _on_SwitchSewerBase_body_entered(body):
	if (body.name == "AlexStates"):
		anim.play("default")
		$CollisionShape2D.disabled

#		switch__sfx.play()


func _on_SwitchSewerBase_body_exited(body):
	if (body.name == "AlexStates"):
		queue_free()

