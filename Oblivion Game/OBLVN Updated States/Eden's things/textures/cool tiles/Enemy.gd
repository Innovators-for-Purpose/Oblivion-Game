extends Area2D

onready var anim = $Anim

func _ready():
	pass # Replace with function body.



func _on_Area2D_body_entered(body):
	if (body.name == "AlexStates"):
#			anim.play("hit")
			queue_free()
#			var y_delta = position.y - body.position.y
##		if (y_delta > 30):
##			print("Destroy Enemy")
#			body.jump()
#		else:
#			print("Decrease health")
#			body.queue_free()
