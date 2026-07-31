extends Area2D

onready var sprite = $"elevator sprite"



func _on_Elevator2_body_entered(body):
	if (body.name == "AlexStates"):
		sprite.modulate.a = 0.5
		


func _on_Elevator2_body_exited(body):
	if (body.name == "AlexStates"):
		sprite.modulate.a = 1.0
