extends Node

#onready var points_label = $"%PointsLabel"


var points = 0
func add_point():
	points += 1
#	points_label.text = "Mask Pieces: " + str(points)
