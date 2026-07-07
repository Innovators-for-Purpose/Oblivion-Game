extends StaticBody2D

signal deal_damage(amount)

var is_touching
var hurtDamage = 10
var playerHealth


func _on_Area2D_body_entered(body):
	if (body.name == "AlexStates"):
		connect("deal_damage", body, "take_damage")
		emit_signal("deal_damage",hurtDamage)


func _on_Area2D_body_exited(body):
	pass # Replace with function body.
