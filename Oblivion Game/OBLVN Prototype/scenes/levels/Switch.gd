extends Area2D


onready var anim = $Sprite
onready var collision_shape_2d = $CollisionShape2D


func _on_Switch_body_entered(body):
	if (body.name == "AlexStates"):
		anim.play("default")
		$CollisionShape2D.disabled
		
		


func _on_Switch_body_exited(body):
	if (body.name == "AlexStates"):
		anim.frame = 0



