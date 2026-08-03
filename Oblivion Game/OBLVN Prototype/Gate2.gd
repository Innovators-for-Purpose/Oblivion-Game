extends StaticBody2D

onready var gateanim2 = $AnimatedSprite
onready var collision_shape_2d = $CollisionShape2D




func _on_Switch2_body_entered(body):
	if (body.name == "AlexStates"):
		gateanim2.play("default")
		$CollisionShape2D.disabled = !$CollisionShape2D.disabled


func _on_AnimatedSprite_animation_finished():
	$CollisionShape2D.disabled = $CollisionShape2D.disabled
