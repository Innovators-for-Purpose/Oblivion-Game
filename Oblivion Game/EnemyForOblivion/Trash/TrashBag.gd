extends Sprite

#func _on_Area2D_body_entered(body):
#	if body.is_in_group("Player"):
#		print("Player touched trash bag.")
#		$TrashAudio.play()
#		Global.trash_audio = true 
#		$Trash_stop.start()
		
func _on_Trash_area_body_entered(body):
	if body.is_in_group("Player"):
		print("Player touched trash bag.")
		$TrashAudio.play()
		Global.trash_audio = true 
		$Trash_stop.start()

func _on_Trash_stop_timeout():
	$TrashAudio.stop()
	Global.trash_audio = false

		
