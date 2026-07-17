extends Area2D

onready var mask_manager = $"../MaskManager"


func _on_Mask_Piece_body_entered(body):
	if (body.name == "AlexStates"):
		mask_manager.add_point()
		queue_free()
		

