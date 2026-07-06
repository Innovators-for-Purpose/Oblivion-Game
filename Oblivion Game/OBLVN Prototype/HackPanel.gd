extends Area2D


onready var lazer = $"../Lazers/Lazer"
onready var collision_shape_2d = $"../Lazers/Lazer/CollisionShape2D"
onready var timer = $"../Lazers/Lazer/Timer"
onready var anim = $"../Lazers/Lazer/Anim"


onready var lazer_19 = $"../Lazers/Lazer19"
onready var anim__19 = $"../Lazers/Lazer19/Anim_19"

func _on_HackPanel_body_entered(body):
	if (body.name == "AlexStates"):
		timer.stop()
		anim.hide()
		collision_shape_2d.set_deferred("disabled", true)
	
	
