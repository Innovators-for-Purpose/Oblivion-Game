extends StaticBody2D

onready var collision_shape_5d = $CollisionShape5D

onready var anim_5 = $Anim5


func _on_Hitbox_body_entered(body):
	if (body.name == "AlexStates"):
		anim_5.play("default")
		$CollisionShape5D.disabled = !$CollisionShape5D.disabled

func _on_AnimatedSprite_animation_finished():
	$CollisionShape5D.disabled = $CollisionShape5D.disabled
