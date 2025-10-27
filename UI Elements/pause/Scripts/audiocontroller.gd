extends Node

onready var vibing = load("res://SFX/Song.mp3")
onready var music_bus = AudioServer.get_bus_index("Music")

func _ready():
	muffle_audio(get_tree().paused)
	

func play_music():
	$AudioStreamPlayer.stream = vibing
	$AudioStreamPlayer.play()
	

func muffle_audio(set):
	if set:
		print("PAUSED")
		AudioServer.set_bus_effect_enabled(music_bus, 0, true)
	else:
		print("RESUMED")
		AudioServer.set_bus_effect_enabled(music_bus, 0, false)
