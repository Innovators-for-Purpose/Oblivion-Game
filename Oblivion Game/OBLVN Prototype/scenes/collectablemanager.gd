extends Node2D


var points = 0
onready var label = $"%Label"

func add_point():
	points += 1
	print(points)
	label.text = "Microchips: " + str(points)
