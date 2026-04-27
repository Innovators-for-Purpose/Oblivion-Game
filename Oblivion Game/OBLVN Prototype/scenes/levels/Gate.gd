extends StaticBody2D

onready var gateanim = $AnimatedSprite

onready var gatecollision = $CollisionShape2D

func _on_Switch_body_entered(body):
	if (body.name == "AlexStates"):
		gateanim.play("default")
		$CollisionShape2D.disabled = !$CollisionShape2D.disabled


func _on_AnimatedSprite_animation_finished():
	$CollisionShape2D.disabled = $CollisionShape2D.disabled
