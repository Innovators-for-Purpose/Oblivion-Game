extends StaticBody2D

onready var gateanim = $AnimatedSprite
onready var scan = $"../CameraScan/AnimatedSprite"
onready var collision_shape_2d = $CollisionShape2D



func _on_AnimatedSprite_animation_finished():
	$CollisionShape2D.disabled = $CollisionShape2D.disabled


func _on_CameraScan_body_entered(body):
	if (body.name == "AlexStates"):
		scan.play("off")
		gateanim.play("default")
		$CollisionShape2D.disabled = !$CollisionShape2D.disabled
