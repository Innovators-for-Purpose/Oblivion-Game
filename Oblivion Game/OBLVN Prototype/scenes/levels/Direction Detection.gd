extends Area2D

var velocity = Vector2(0,0)
var speed = 35

func _on_Direction_Detection_body_entered(body):
	if (body.name == "Guard"):
		velocity.x = speed

