extends StaticBody2D
var health = 2







func take_damage(amount: int):
	health -= amount
	if health <= 0:
		queue_free()


func _on_ministinger_body_entered(body):
	if (body.name == "AlexStates"):
			take_damage(1)

