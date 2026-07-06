extends StaticBody2D

onready var gateanim = $AnimatedSprite
onready var switchanim = $"../Switch/AnimatedSprite"

onready var collision_shape_2d = $CollisionShape2D

func _on_hitbox_body_entered(body):
	if (body.name == "AlexStates"):
		gateanim.play("default")
		switchanim.play("default")
		$CollisionShape2D.disabled = !$CollisionShape2D.disabled




func _on_Switch_body_entered(body):
	if (body.name == "AlexStates"):
		gateanim.play("default")
		switchanim.play("default")
		$CollisionShape2D.disabled = !$CollisionShape2D.disabled


func _on_AnimatedSprite_animation_finished():
	$CollisionShape2D.disabled = $CollisionShape2D.disabled
