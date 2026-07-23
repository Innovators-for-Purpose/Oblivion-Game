extends Area2D

onready var sfx = $"../bee boss music"
onready var level__music = $"../Level Music"



func _on_Boss_Arena_detection_body_entered(body):
	if (body.name == "AlexStates"):
		level__music.stop()
		sfx.play()
		
	else:
		level__music.play()

