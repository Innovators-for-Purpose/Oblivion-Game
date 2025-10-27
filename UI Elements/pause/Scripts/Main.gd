extends Node2D

func _ready():
	print("NOW PLAYING IN SCENE: " + filename)
	Audiocontroller.play_music()
