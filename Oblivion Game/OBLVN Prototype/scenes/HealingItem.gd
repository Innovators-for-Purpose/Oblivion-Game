extends Node2D

onready var anim = $AnimationPlayer
onready var particles = $Particles



func _on_Area2D_body_entered(body):
	if "AlexStates" in body.name:
		$Sprite.hide()
		particles.emitting = true
		$Despawn.start()



func _on_Despawn_timeout():
	queue_free()
