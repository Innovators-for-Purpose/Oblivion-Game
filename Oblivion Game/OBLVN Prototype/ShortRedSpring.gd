extends Area2D

onready var anim = $AnimatedSprite
onready var sfx = $sfx





func _on_ShortRedSpring_body_entered(body):
	if (body.name == "AlexStates"):
		body.velocity.y = (-1950 + 100) 
		anim.play("default")
		sfx.play()




func _on_ShortRedSpring_body_exited(body):
	if (body.name == "AlexStates"):
		anim.frame = 0

