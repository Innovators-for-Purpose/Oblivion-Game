extends Node

var levels = [
	"res://scenes/levels/level0_house.tscn",
	"res://scenes/levels/level2.tscn",
	"res://scenes/levels/AssemblyPlantsave.tscn",
]

var current_level_index = 0

func get_current_level():
	return levels[current_level_index]

func load_next_level():
	current_level_index += 1
	if current_level_index >= levels.size():
		current_level_index = 0  # or end-game scene
	get_tree().change_scene(levels[current_level_index])
	

