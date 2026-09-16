extends StaticBody2D

onready var gateanim = $AnimatedSprite

onready var gatecollision = $CollisionShape2D

onready var glow = $"../CameraScan/AnimatedSprite"

func _on_AnimatedSprite_animation_finished():
	$CollisionShape2D.disabled = $CollisionShape2D.disabled
	

func _on_CameraScan_body_entered(body):
	if (body.name == "AlexStates"):
		glow.play("off")
		gateanim.play("default")
		$CollisionShape2D.disabled = !$CollisionShape2D.disabled
