extends Node2D

#onready var anim = $AnimationPlayer
onready var particles = $Particles



func _on_Area2D_body_entered(body):
	if "AlexStates" in body.name:
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		$Sprite.hide()
		particles.emitting = true
		$Sound.play()
		$Despawn.start()



func _on_Despawn_timeout():
	queue_free()
