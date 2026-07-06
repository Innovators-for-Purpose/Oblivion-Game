extends PathFollow2D

var progress_ratio = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	progress_ratio += delta * 0.2 

