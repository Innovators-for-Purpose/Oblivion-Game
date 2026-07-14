extends StaticBody2D

onready var collision_shape_5d = $CollisionShape5D

onready var anim_5 = $Anim5


func _on_boss_dead():
	anim_5.play("default")

func _on_AnimatedSprite_animation_finished():
	$CollisionShape5D.disabled = !$CollisionShape5D.disabled
