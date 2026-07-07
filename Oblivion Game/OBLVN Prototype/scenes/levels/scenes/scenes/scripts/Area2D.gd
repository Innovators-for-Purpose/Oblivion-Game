extends Area2D
onready var audio_stream_player_2d = $AudioStreamPlayer2D


func _on_Fall_body_entered(body):
	if (body.name == "AlexStates"):
		get_tree().reload_current_scene()
		audio_stream_player_2d.play()
